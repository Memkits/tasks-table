
var
  React $ require :react/addons
  Immutable $ require :immutable
  ssf $ require :ssf
  keycode $ require :keycode

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
    :onDateDelete React.PropTypes.func.isRequired

  :onContentChange $ \ (event)
    this.props.onContentChange (this.props.task.get :Create_time) event.target.value

  :onDateKeyDown $ \ (event)
    var value event.target.value
    if (is (keycode event.keyCode) :backspace) $ do
      event.preventDefault
      setTimeout $ \\ ()
        this.props.onDateDelete value
    return undefined

  :render $ \ ()
    var task this.props.task
    var style $ {}
      :top $ * this.props.index 30

    div ({} (:className :app-task) (:style style))
      input $ {} (:className :create_time)
        :value $ ssf.format :mm/dd (task.get :Create_time)
        :onChange $ \ ()
        :onKeyDown this.onDateKeyDown
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
