def get_teams_info
    teams= ['athletic-club', 'atletico-de-madrid', 'c-a-osasuna', 'cadiz-cf', 'd-alaves', 'fc-barcelona', 'getafe-cf', 'girona-fc', 'granada-cf','rayo-vallecano', 'rc-celta', 'rcd-mallorca', 'real-betis', 'real-madrid', 'real-sociedad', 'sevilla-fc', 'ud-almeria', 'ud-las-palmas', 'valencia-cf', 'villarreal-cf']
    
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
  
        })

        puts "Standing for #{name} created"
    end
end

get_teams_info
get_standings
