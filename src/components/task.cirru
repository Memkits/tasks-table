
var
  React $ require :react/addons
  Immutable $ require :immutable
  ssf $ require :ssf

var
  div $ React.createFactory :div
  input $ React.createFactory :input

= module.exports $ React.createClass $ {}
  :displayName :app-task
  :mixins $ [] React.addons.PureRenderMixin

  :propTypes $ {}
    :task $ React.PropTypes.instanceOf Immutable.Map
    :index React.PropTypes.number.isRequired
    :onContentChange React.PropTypes.func.isRequired

  :onContentChange $ \ (event)
    this.props.onContentChange (this.props.task.get :id) event.target.value

  :render $ \ ()
    var task this.props.task
    var style $ {}
      :top $ * this.props.index 30

    div ({} (:className :app-task) (:style style))
      div ({} (:className :create_time))
        ssf.format :mm/dd (task.get :Create_time)
      div ({} (:className :creator))
        task.get :Creator
      div ({} (:className :group))
        task.get :Group
      div ({} (:className :stage))
        task.get :Stage
      input
        {} (:className :content)
          :value (task.get :Content)
          :onChange this.onContentChange
