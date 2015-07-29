
var
  page $ require :./page
  store $ require :./store
  view $ require :./view
  session $ require :./session

view.out.forward store.in
store.out.forward page.in
store.out.forward session.in
