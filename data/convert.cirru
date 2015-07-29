
var
  xlsx $ require :node-xlsx
  fs $ require :fs

var content $ fs.readFileSync :web.xlsx

var obj $ xlsx.parse content
var whole $ . obj 0
var data whole.data

var labels $ . data 0
var rest $ data.slice 1

var newList $ rest.map $ \ (row)
  var coll $ {}
  row.forEach $ \ (piece index)
    var label $ . labels index
    = (. coll label) piece
  return coll

fs.writeFileSync :web.json $ JSON.stringify newList null 2
