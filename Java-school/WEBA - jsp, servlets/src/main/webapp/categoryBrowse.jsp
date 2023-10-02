<%@ page import="sk.matejcik.SemestralnaPraca.Category.CategoryController" %>
<%@ page import="sk.matejcik.SemestralnaPraca.Category.Category" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<% request.getSession().setAttribute("navbarType","categories");%>
<%@include file="navbar.jsp" %>
<div id="App"></div>

<script type="text/babel">
    class SearchBar extends React.Component {
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
    class Category extends React.Component {

        handleClick() {
                window.location.href = "booksBrowse.jsp?category="+this.props.id
        }

        render() {
            return (
                <button
                    className="m-1 p-2 bg-success text-white border border-secondary rounded category-item" onClick={this.handleClick.bind(this)}>{this.props.name}</button>
            )
        }

    }
    class CategoryDelete extends React.Component {

        render() {
            return (
                <button
                    className="m-1 p-2 bg-danger text-white border border-secondary rounded category-item">{this.props.name}</button>
            )
        }

    }
    class AllCategories extends React.Component {
        constructor() {
            super();
            this.getCategories = this.getCategories.bind(this)
            this.state = {
                categories: []
            }
            this.getCategories()
        }

        getCategories() {
            var that = this
            var allCategories = []
            $.ajax({
                url: 'get-categories-servlet',
                type: 'POST',
                success: function (data) {
                    data.forEach(category => {
                        allCategories.push([category.category_id,category.name])
                    })
                },
                complete: function () {
                    that.setState({
                        categories: allCategories
                    })
                }
            })
        }

        render() {
            return (
                <div className="d-flex flex-wrap ml-5 mr-5 mt-2">
                    {this.state.categories.map((category) => {
                        if (category[1].toLowerCase().search(this.props.search.toLowerCase()) !== -1) {
                            if (this.props.deleteValue === true) {
                                return <CategoryDelete key={category[0]} name={category[1]}/>
                            } else {
                                return <Category key={category[0]} name={category[1]} id={category[0]}/>
                            }

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
                search: '',
                deleteValue: ''
            }
        }

        onChangeSearch = (search) => {
            this.setState({
                search: search
            })
        }

        onChangeDelete = (value) => {
            this.setState({
                deleteValue: value
            })
        }

        render() {
            return (
                <div>
                    <SearchBar searchCallback={this.onChangeSearch} deleteCallback={this.onChangeDelete}/>
                    <AllCategories search={this.state.search} deleteValue={this.state.deleteValue}/>
                </div>
            )
        }
    }

    ReactDOM.render(<App/>, document.querySelector("#app"));
</script>

</body>
</html>
