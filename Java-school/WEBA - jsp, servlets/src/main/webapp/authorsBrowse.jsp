<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<% request.getSession().setAttribute("navbarType","authors");
%>
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
    class Author extends React.Component {

        onClickHandler() {
            window.location.href = "authorProfile.jsp?id="+this.props.id
        }

        render() {
            return (
                <button className="m-1 p-2 border border-secondary rounded author-item" onClick={this.onClickHandler.bind(this)}>
                    { this.props.picture === ""
                        ? <img className="author-item-image" src="https://bootdey.com/img/Content/avatar/avatar7.png" width="150"></img>
                        : <img className="author-item-image" src={this.props.picture} width="150"></img>}
                    <br/>
                    <p className="author-item-name">{this.props.name}</p>
                    <p className="author-item-name">{this.props.lastname}</p>
                </button>

            )
        }

    }
    class AllAuthors extends React.Component {
        constructor() {
            super();
            this.getAuthors = this.getAuthors.bind(this)
            this.state = {
                authors: []
            }
            this.getAuthors()
        }

        getAuthors() {
            var that = this
            var allAuthors = []
            $.ajax({
                url: 'get-authors-servlet',
                type: 'POST',
                datatype: "json",
                success: function (data) {
                    data.forEach(author => {
                        allAuthors.push([author.author_id,author.name,author.lastname,author.picture])
                    })
                },
                complete: function () {
                    that.setState({
                        authors: allAuthors,
                    })
                }
            })
        }

        render() {
            return (
                <div className="d-flex flex-wrap ml-5 mr-5 mt-2">
                    {this.state.authors.map((author) => {
                        if (author[1].toLowerCase().search(this.props.search.toLowerCase()) !== -1 || author[2].toLowerCase().search(this.props.search.toLowerCase()) !== -1) {
                                return <Author key={author[0]} name={author[1]} lastname={author[2]} id={author[0]} picture={author[3]}/>
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
                    <AllAuthors search={this.state.search} />
                </div>
            )
        }
    }

    ReactDOM.render(<App/>, document.querySelector("#app"));
</script>

</body>
</html>