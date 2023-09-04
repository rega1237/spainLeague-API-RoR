def get_teams_info

    # all teams
    teams= ['athletic-club', 'atletico-de-madrid', 'c-a-osasuna', 'cadiz-cf', 'd-alaves', 'fc-barcelona', 'getafe-cf', 'girona-fc', 'granada-cf','rayo-vallecano', 'rc-celta', 'rcd-mallorca', 'real-betis', 'real-madrid', 'real-sociedad', 'sevilla-fc', 'ud-almeria', 'ud-las-palmas', 'valencia-cf', 'villarreal-cf']
   
    #search all teams info on laliga.com
    teams.each do |team|
        doc = Nokogiri::HTML(URI.open("https://www.laliga.com/en-GB/clubs/#{team}"))

        team_table = doc.css("table.styled__ClubInfoTextData-sc-112pon1-4.bxbeUB")

        Team.create({
            name: doc.css("div.styled__ClubInfo-sc-112pon1-1.gDPpoT div.styled__ClubInfoText-sc-112pon1-3.fgHhgL p").first.text,
            shield: doc.css("div.styled__ShieldContainer-sc-1opls7r-0.eIaTDi img").attribute('src').value,
            stadium: team_table.css("tr:nth-child(2) td:nth-child(2)").text,
            year: team_table.css("tr:nth-child(2) td").first.text,
            president: team_table.css("tr:nth-child(4) td:nth-child(1)").text,
            site: team_table.css("tr:nth-child(4) td:nth-child(2)").text
        })

        puts "Team #{team} created"
    end
end

def get_standings
    doc = Nokogiri::HTML(URI.open('https://www.mundodeportivo.com/resultados/futbol/laliga/clasificacion'))

    standings_rows = doc.css('.table tr:not(.table-header)').collect

    all_teams = Team.all

    standings_rows.each do |team|

        #img= team.css('td.tname div.tflex a img').attribute('src').value
        name = team.css('td.tname div.tflex div.tflex__content p a').text

        name_longest_part = name.split(' ').max_by(&:length)

        pj = team.css('td:nth-child(2)').text
        pg = team.css('td:nth-child(3)').text
        pe = team.css('td:nth-child(4)').text
        pp = team.css('td:nth-child(5)').text
        gf = team.css('td:nth-child(6)').text
        gc = team.css('td:nth-child(7)').text
        pts = team.css('td:nth-child(8)').text

        if name_longest_part == 'Madrid'
            name_longest_part = 'Real Madrid'
        end

        team = all_teams.where("name LIKE ?", "%#{name_longest_part}%").first

        Standing.create({
            team_id: team.id,
            played: pj,
            won: pg,
            draw: pe,
            lose: pp,
            goals_for: gf,
            goals_against: gc,
            points: pts,
            name_for_table: name
        })

        puts "Standing for #{name} created"
    end
end

def get_fixtures
    url = 'https://www.marca.com/futbol/primera-division/calendario.html'

    doc = Nokogiri::HTML(URI.open(url))

    tables = doc.css('div#contenedorCalendarioInt div.jornada.calendarioInternacional div.cal-agendas.calendario div.jornada.datos-jornada table.jor.agendas')

    tables.each do |table|
        matchday = table.css('caption').text
        matchday['Jornada '] = 'Matchday '
        puts "---------------------------------"
        puts matchday
        rows = table.css('tbody tr')
        rows.each do |row|
            home = row.css('td.local').text.strip
            away = row.css('td.visitante').text.strip
            result_row = row.css('td.resultado')

            # get team home
            all_teams = Team.all

            name_longest_part_home = home.split(' ').max_by(&:length)
            
            if name_longest_part_home == 'Madrid'
                name_longest_part_home = 'Real Madrid'
            end
            
            team_home = all_teams.where("name LIKE ?", "%#{name_longest_part_home}%").first

            # get team away
            name_longest_part_away = away.split(' ').max_by(&:length)

            if name_longest_part_away == 'Madrid'
                name_longest_part_away = 'Real Madrid'
            end

            team_away = all_teams.where("name LIKE ?", "%#{name_longest_part_away}%").first

            if result_row.text.length > 5
                result = result_row.text.strip.split(" ")
                Fixture.create({
                    matchday: matchday,
                    home_id: team_home.id,
                    away_id: team_away.id,
                    result: "upcoming",
                    day: result[0],
                    hour: result[1]
                })
                             
                puts "Fixture #{home} vs #{away} created"
            else
                Fixture.create({
                    matchday: matchday,
                    home_id: team_home.id,
                    away_id: team_away.id,
                    result: result_row.text.strip,
                    day: "finished",
                    hour: "finished"
                })

                puts "Fixture #{home} vs #{away} created"
            end
        end
    end
end

get_teams_info
get_standings
get_fixtures