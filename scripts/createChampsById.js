let fs = require('fs');
let path = require('path')
let championJSON = JSON.parse(fs.readFileSync(path.resolve(__dirname,'../rawData/champion.json'), 'utf-8'));

let champsById = {};
for (const champName in championJSON.data) {
    const champId = championJSON.data[champName].key
    champsById[champId] = champName;
}

fs.writeFile(path.resolve(__dirname, '../assets/champion/championsById.json'), JSON.stringify(champsById), function (err) {
  if (err) throw err;
  console.log('Saved!');
})