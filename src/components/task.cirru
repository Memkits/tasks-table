
var
  React $ require :react
  Immutable $ require :immutable

var
  div $ React.createFactory :div

= module.exports $ React.createClass $ {}
  :displayName :app-task

  :propTypes $ {}
    :task $ React.PropTypes.instanceOf Immutable.Map

  :render $ \ ()
    var task this.props.task
    div ({} (:className :app-task))
      div ({} (:className :content))
        task.get :Content
      div ({} (:className :priority))
        task.get :Priority
      div ({} (:className :complete))
        task.get :Complete
      div ({} (:className :create_time))
        task.get :Create_time
      div ({} (:className :due_date))
        task.get :Due_Date
      div ({} (:className :executor))
        task.get :Executor
      div ({} (:className :group))
        task.get :Group
      div ({} (:className :stage))
        task.get :Stage
