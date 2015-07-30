
var
  React $ require :react
  Immutable $ require :immutable
  classnames $ require :classnames

var
  Task $ React.createFactory $ require :./task
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-table

  :propTypes $ {}
    :tasks $ React.PropTypes.instanceOf Immutable.List
    :labels $ React.PropTypes.instanceOf Immutable.List
    :onContentChange React.PropTypes.func.isRequired
    :onDateDelete React.PropTypes.func.isRequired

  :getInitialState $ \ ()
    {} (:sortKey :Content)

  :onLabelClick $ \ (label)
    this.setState $ {} (:sortKey label)

  :render $ \ ()
    var dataviewStyle $ {}
      :height $ * this.props.tasks.size 30

    div ({} (:className :app-table))
      div ({} (:className :control))
        ... this.props.labels
          map $ \\ (label index)
            var onClick $ \\ ()
              this.onLabelClick label
            var className $ classnames :label
              label.toLowerCase
            div
              {} (:className className) (:key index)
                :onClick onClick
              , label
      div ({} (:className :dataview) (:style dataviewStyle))
        cond (> this.props.tasks.size 0)
          ... this.props.tasks
            sortBy $ \\ (task)
              task.get this.state.sortKey
            map $ \\ (task index)
              Task $ {} (:task task) (:key (task.get :Create_time)) (:index index)
                :onContentChange this.props.onContentChange
                :onDateDelete this.props.onDateDelete
            sortBy $ \ (component)
              , component.key
          div ({} (:className :start)) ":Drop xlsx file to start..."
