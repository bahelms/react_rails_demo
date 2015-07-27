@Records = React.createClass
  getInitialState: ->
    # sets @state attribute
    records: @props.data

  getDefaultProps: ->
    # sets default @props if no data was given to 'react_component'
    records: []

  # required; renders the component
  render: ->
    React.DOM.div
      className: "records"
      React.DOM.h2
        className: "title"
        "Records"
      React.DOM.table
        className: "table table-bordered"
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, "Date"
            React.DOM.th null, "Title"
            React.DOM.th null, "Amount"
        React.DOM.tbody null,
          for record in @state.records
            React.createElement Record, key: record.id, record: record

  # JSX syntax
  # render: ->
  #   `<div className="records">
  #     <h2 className="title">Records<h2>
  #   </div>`
