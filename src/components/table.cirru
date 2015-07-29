
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

  :getInitialState $ \ ()
    {} (:sortKey :Content)

  :onLabelClick $ \ (label)
    this.setState $ {} (:sortKey label)

  :render $ \ ()
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
      ... this.props.tasks
        sortBy $ \\ (task)
          task.get this.state.sortKey
        map $ \ (task index)
          Task $ {} (:task task) (:key index)
