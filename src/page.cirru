
var
  React $ require :react
  schema $ require :./schema
  Pipeline $ require :cumulo-pipeline
  qwest $ require :qwest
  Immutable $ require :immutable

= exports.in $ new Pipeline

var
  Component $ React.createFactory $ require :./components/table
  div $ React.createFactory :div

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    {} (:tasks schema.store)

  :componentDidMount $ \ ()
    exports.in.for $ \\ (store)
      this.setState $ {} (:tasks store)
    ... qwest
      get :data/web.json
      then $ \\ (resp)
        var allData $ Immutable.fromJS $ JSON.parse resp.response
        var obj $ allData.get 0
        this.setState $ {}
          :tasks (obj.get :data)

  :render $ \ ()
    console.log (this.state.tasks.toJS)

    div ({} (:className :app-page))
      Component $ {} (:tasks this.state.tasks)

var Page $ React.createFactory pageComponent

React.render (Page) document.body
