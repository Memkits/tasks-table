
var
  React $ require :react
  schema $ require :./schema
  Pipeline $ require :cumulo-pipeline
  qwest $ require :qwest
  Immutable $ require :immutable
  shortid $ require :shortid

= exports.in $ new Pipeline

var
  Table $ React.createFactory $ require :./components/table
  div $ React.createFactory :div

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    {} (:tasks schema.store)
      :labels $ Immutable.fromJS $ []
        , :Create_time
        , :Creator
        , :Group
        , :Stage
        , :Content

  :componentDidMount $ \ ()
    exports.in.for $ \\ (store)
      this.setState $ {} (:tasks store)
    ... qwest
      get :data/web.json
      then $ \\ (resp)
        var allData $ Immutable.fromJS $ JSON.parse resp.response
        this.setState $ {}
          :tasks $ allData.map $ \ (task)
            task.set :id (shortid.generate)

  :onContentChange $ \ (id text)
    this.setState $ {} $ :tasks
      this.state.tasks.map $ \ (task)
        cond (is (task.get :id) id)
          task.set :Content text
          , task

  :render $ \ ()

    div ({} (:className :app-page))
      Table $ {} (:tasks this.state.tasks) (:labels this.state.labels)
        :onContentChange this.onContentChange

var Page $ React.createFactory pageComponent

React.render (Page) document.body
