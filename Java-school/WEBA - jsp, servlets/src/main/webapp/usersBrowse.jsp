<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<% request.getSession().setAttribute("navbarType","users");%>
<%@include file="navbar.jsp" %>

<div id="App"></div>

<script type="text/babel">
    class SearchBar extends React.Component {
        constructor(props) {
            super();
        }
        handleSearch(event) {
            this.props.searchCallback(event.target.value);
        }
        render() {
            return (
                <div className="w-100">
                    <div>
                        <form className="form-inline ">
                            <input className="form-control category-search" type="search" placeholder="Search"
                                   aria-label="Search" onChange={this.handleSearch.bind(this)}/>
                        </form>
                    </div>
                    <div className="green-line"/>
                </div>
            )
        }
    }
    class User extends React.Component {

        onClickHandler() {
            window.location.href = "userProfile.jsp?id="+this.props.id
        }

        render() {
            return (
                <button className="m-1 p-2 border border-secondary rounded author-item" onClick={this.onClickHandler.bind(this)}>
                    <img className="author-item-image" src="https://bootdey.com/img/Content/avatar/avatar7.png"></img>
                    <br/>
                    <p className="author-item-name">{this.props.name}</p>
                    <p className="author-item-name">{this.props.lastname}</p>
                </button>

            )
        }

    }
    class AllUsers extends React.Component {
        constructor() {
            super();
            this.getUsers = this.getUsers.bind(this)
            this.state = {
                users: []
            }
            this.getUsers()
        }

        getUsers() {
            var that = this
            var allUsers = []
            $.ajax({
                url: 'get-user-servlet',
                type: 'POST',
                datatype: "json",
                success: function (data) {
                    data.forEach(user => {
                        allUsers.push([user.user_id,user.name,user.lastname,user.picture])
                    })
                },
                complete: function () {
                    that.setState({
                        users: allUsers,
                    })
                }
            })
        }

        render() {
            return (
                <div className="d-flex flex-wrap ml-5 mr-5 mt-2">
                    {this.state.users.map((user) => {
                        if (user[1].toLowerCase().search(this.props.search.toLowerCase()) !== -1 || user[2].toLowerCase().search(this.props.search.toLowerCase()) !== -1) {
                            return <User key={user[0]} name={user[1]} lastname={user[2]} id={user[0]}/>
                        }
                    })
                    }
                </div>
            );
        }
    }
    class App extends React.Component {

        constructor() {
            super();
            this.state = {
                search: ''
            }
        }

        onChangeSearch = (search) => {
            this.setState({
                search: search
            })
        }

        render() {
            return (
                <div>
                    <SearchBar searchCallback={this.onChangeSearch}/>
                    <AllUsers search={this.state.search} />
                </div>
            )
        }
    }

    ReactDOM.render(<App/>, document.querySelector("#app"));
</script>

</body>
</html>
