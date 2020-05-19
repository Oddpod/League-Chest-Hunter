const fetch =  require('node-fetch');
const RIOT_API_ROOT_LOL = "https://euw1.api.riotgames.com/lol/";

module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');
    
    const apiToken = process.env.RIOT_API_KEY;
    if (req.query.name || (req.body && req.body.name)) {
        const summonerId = req.body.summonerId || (await fetch(`${RIOT_API_ROOT_LOL}summoner/v4/summoners/by-name/${req.body.summonerId}`, {
            headers: {
                'X-Riot-Token': apiToken
            }
        }).then(response => response.json())).id
        const response = await fetch(`${RIOT_API_ROOT_LOL}champion-mastery/v4/champion-masteries/by-summoner/${summonerId}`, {
            headers: {
                'X-Riot-Token': apiToken
            }
        })
        context.res = {
            // status: 200, /* Defaults to 200 */
            body: { 'championMastery': await response.json(), summonerId }
        };
    }
    else {
        context.res = {
            status: 400,
            body: "Please pass a name on the query string or in the request body"
        };
    }
};