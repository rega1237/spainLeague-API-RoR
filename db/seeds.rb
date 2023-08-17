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

get_teams_info

