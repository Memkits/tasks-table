
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
    this.listenDrop

  :requestData $ \ ()
    ... qwest
      get :data/web.json
      then $ \\ (resp)
        var allData $ Immutable.fromJS $ JSON.parse resp.response
        this.setState $ {} (:tasks allData)

  :listenDrop $ \ ()
    = document.body.ondrageter $ \ (event)
      return false
    = document.body.ondragover $ \ (event)
      return false
    = document.body.ondrop $ \\ (event)
      event.stopPropagation
      event.preventDefault
      var files $ Array.apply null event.dataTransfer.files
      files.forEach $ \\ (f)
        var reader $ new FileReader
        reader.readAsBinaryString f
        = reader.onload $ \\ (event)
          var data event.target.result
          var workbook $ XLSX.read data $ {} (:type :binary)
          var keys $ Object.keys workbook.Sheets
          keys.forEach $ \\ (key)
            var tasks $ XLSX.utils.sheet_to_json (. workbook.Sheets key) $ {} (:raw true)
            this.handleTasks $ Immutable.fromJS tasks
      return false

  :handleTasks $ \ (tasks)
    this.setState $ {} $ :tasks $ this.state.tasks.concat tasks

  :onContentChange $ \ (id text)
    this.setState $ {} $ :tasks
      this.state.tasks.map $ \ (task)
        cond (is (task.get :Create_time) id)
          task.set :Content text
          , task

  :onDateDelete $ \ (date)
    this.setState $ {} $ :tasks
      this.state.tasks.filter $ \ (task)
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
