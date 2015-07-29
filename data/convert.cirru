
var
  xlsx $ require :node-xlsx
  fs $ require :fs

var content $ fs.readFileSync :web.xlsx

var obj $ xlsx.parse content

fs.writeFileSync :web.json $ JSON.stringify obj null 2
