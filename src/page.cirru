
var
  React $ require :react
  schema $ require :./schema
  Pipeline $ require :cumulo-pipeline
  qwest $ require :qwest
  Immutable $ require :immutable
  shortid $ require :shortid
  ssf $ require  :ssf
  keycode $ require :keycode

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

  :onDateDelete $ \ (date)
    this.setState $ {} $ :tasks
      this.state.tasks.filter $ \ (task)
          ssf.format :mm/dd (task.get :Create_time)
        isnt
          ssf.format :mm/dd (task.get :Create_time)
          , date

  :render $ \ ()

    div ({} (:className :app-page))
      Table $ {} (:tasks this.state.tasks) (:labels this.state.labels)
        :onContentChange this.onContentChange
        :onDateDelete this.onDateDelete

var Page $ React.createFactory pageComponent

React.render (Page) document.body

window.addEventListener :keydown $ \ (event)
  if
    and
      is (keycode event.keyCode) :backspace
      isnt event.target.tagName :INPUT
    do
      event.preventDefault
  return undefined
