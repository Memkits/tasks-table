
var
  Pipeline $ require :cumulo-pipeline

= exports.in $ new Pipeline

exports.in.for $ \ (data)
  console.log :saving data
