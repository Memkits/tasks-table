
var
  React $ require :react
  schema $ require :./schema
  Pipeline $ require :cumulo-pipeline
  qwest $ require :qwest
  Immutable $ require :immutable

= exports.in $ new Pipeline

var
  Table $ React.createFactory $ require :./components/table
  div $ React.createFactory :div

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    {} (:tasks schema.store)
      :labels $ Immutable.fromJS $ []
        , :Content
        , :Priority
        , :Complete
        , :Create_time
        , :Due_Date
        , :Executor
        , :Group
        , :Stage

  :componentDidMount $ \ ()
    exports.in.for $ \\ (store)
      this.setState $ {} (:tasks store)
    ... qwest
      get :data/web.json
      then $ \\ (resp)
        var allData $ Immutable.fromJS $ JSON.parse resp.response
        this.setState $ {}
          :tasks allData

  :render $ \ ()
    console.log (this.state.tasks.toJS)

    div ({} (:className :app-page))
      Table $ {} (:tasks this.state.tasks) (:labels this.state.labels)

var Page $ React.createFactory pageComponent

React.render (Page) document.body
