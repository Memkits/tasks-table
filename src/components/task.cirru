
var
  React $ require :react
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-task

  :propTypes $ {}
    :task $ React.PropTypes.instanceOf Immutable.List

  :render $ \ ()
    div ({} (:className :app-task))
      ... this.props.task
        map $ \ (field index)
          div ({} (:className :app-field) (:key index)) field
        toArray
