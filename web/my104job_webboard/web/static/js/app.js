// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

var JobColumn = React.createClass({
  getpriceLevel: function (pp){
    if(pp >= 40000 && pp <= 70000){
      return "label label-success btn-sm"
    }
    else if(pp > 70000){
      return "label label-danger btn-sm"
    }
    else{
      return "label label-default btn-sm"
    }
  },
  render: function(){
    return(
      <tr>
        <td id="postdate">{this.props.data.create_at}</td>
        <td><a target="_blank" href={"http://www.104.com.tw/jobbank/custjob/index.php?r=cust&j=" + this.props.data.j}>{
              this.props.data.company_name}
            </a>
        </td>
        <td>{this.props.data.job_name}</td>
        <td id="paid"><span className={this.getpriceLevel(this.props.data.sal_low)}>{this.props.data.sal_low + "~" + this.props.data.sal_high}</span></td>
        <td id="area">{this.props.data.area}</td>
      </tr>
    )
  }
})
var Numberinfo = React.createClass({
  render: function(){
    return (
      <div>
        <span className="lable label-success btn-sm" id="recordnum"> 共有 {this.props.recordnum} 筆工作資料</span>
      </div>
    )
  }
})

var JobBody = React.createClass({
  render: function(){
    var raw = []
    var counter = 0
    this.props.jobdata.forEach(function(data){
      if(this.props.filterText != '' && data.company_name.indexOf(this.props.filterText) === -1 ){
        return
      }else{
        console.log()
        if(this.props.filterMixPric < data.sal_low ){
          raw.push(<JobColumn data={data} key={ data.company_name + data.job_name } />)
          counter += 1
        }
        else{
          return
        }
      }
    }.bind(this));
    return(
      <span>
        <nav className="navbar navbar-default">
          <Numberinfo recordnum={counter} />
        </nav>
        <table className="table">
          <thead>
            <tr>
              <th id="postdate">最後更新</th>
              <th>公司名稱</th>
              <th>職稱</th>
              <th id="paid">薪水</th>
              <th id="area">地區</th>
            </tr>
          </thead>
          <tbody>
            {raw}
          </tbody>
        </table>
      </span>
    )
  }
})
var SearchForm = React.createClass({
  handleChange: function() {
    this.props.onUserInput(
      this.refs.filterTextInput.value,
      this.refs.filterMixPricInput.value
    );
  },
  render: function() {
    return (
      <form className="navbar-form">
        <input type="text"
             placeholder="查詢公司名稱"
             value={this.props.filterText}
             ref="filterTextInput"
             onChange={this.handleChange}
             className="form-control"
        />
        <input type="text"
             placeholder="請輸入薪水下限"
             value={this.props.filterMixPric}
             ref="filterMixPricInput"
             onChange={this.handleChange}
             className="form-control"
        />
      </form>
    );
  }
});
var JobTable = React.createClass({
  getInitialState: function(){
    return {
      filterText: '',
      filterMixPric: '',
      jobdata: []
    }
  },
  componentDidMount: function(){
    $.get(this.props.qurl, function(result){
      var sort_result = _.sortBy(result, function(j){
        return - Date.parse(j.create_at);
      });
      this.setState({
        jobdata: sort_result
      })
    }.bind(this));
  },
  handleUserInput: function(filterText, filterMixPric) {
    this.setState({
        filterText: filterText,
        filterMixPric: filterMixPric
    });
  },
  render: function(){
    return (
      <div className="panel panel-default">
        <SearchForm filterText={this.state.filterText} filterMixPric={this.state.filterMixPric} onUserInput={this.handleUserInput}/>
        <JobBody jobdata={this.state.jobdata} filterText={this.state.filterText} filterMixPric={this.state.filterMixPric}/>
      </div>
    )
  }
})
ReactDOM.render(
  <JobTable qurl="/joblistapi" />,
  document.getElementById("myreact")
)
