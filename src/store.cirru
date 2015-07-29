
var
  Pipeline $ require :cumulo-pipeline
  Immutable $ require :immutable
  schema $ require :./schema

= exports.in $ new Pipeline

var initial schema.store

= exports.out $ exports.in.reduce initial $ \ (store action)
  return store
