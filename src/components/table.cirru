
var
  React $ require :react
  Immutable $ require :immutable

var
  Task $ React.createFactory $ require :./task
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-table

  :propTypes $ {}
    :tasks $ React.PropTypes.instanceOf Immutable.List

  :render $ \ ()
    div ({} (:className :app-table))
      ... this.props.tasks
        map $ \ (task index)
          Task $ {} (:task task) (:key index)
        toArray