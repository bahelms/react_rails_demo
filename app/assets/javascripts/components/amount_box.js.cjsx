@AmountBox = React.createClass
  render: ->
    # using sprockets-coffee-react
    <div className="col-md-3">
      <div className="panel panel-#{@props.type}">
        <div className="panel-heading">
          { @props.text }
        </div>
        <div className="panel-body">
          { amountFormat(@props.amount) }
        </div>
      </div>
    </div>

