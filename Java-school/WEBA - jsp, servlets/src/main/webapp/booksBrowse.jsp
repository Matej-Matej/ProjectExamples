
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<% request.getSession().setAttribute("navbarType","books");%>
<%@include file="navbar.jsp" %>
<div id="App"></div>

<script type="text/babel">
    class GetAllCategories extends React.Component {

        constructor(props) {
            super(props);
            this.getCategories = this.getCategories.bind(this)
            this.state = {
                categories: []
            }
            this.getCategories()
        }

        handleChange(event) {
            this.props.selectCallback(event.target.value,this.props.index);
            window.location.href = "booksBrowse.jsp?category=" + event.target.value
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
                <div className="form-group">
                    <select placeholder="Select category" className="form-select books-browse-category" aria-label="Disabled select example" onChange={this.handleChange.bind(this)}>
                        <option key="-1" value="">All categories</option>
                        {this.state.categories.map((category) => {
                            const categoryUrl = new URLSearchParams(location.search)
                            var selected = (categoryUrl !== null && category[0] == categoryUrl.get('category'))
                            return (
                                <option selected={selected} key={category[0]} value={category[0]}>{category[1]}</option>
                            )
                        })
                        }
                    </select>
                </div>
            )
        }
    }
    class SearchBar extends React.Component {
        constructor(props) {
            super();
            this.state = {
                category: ''
            }

        }
        handleSearch(event) {
            this.props.searchCallback(event.target.value);
            this.setState({
                category: event.target.value
            })
        }
        handleCategoryOption(event) {
            this.props.handleCategoryOption(event)
        }

        render() {
            return (
                <div className="w-100">
                    <div>
                        <form className="form-inline ">
                            <input className="form-control category-search" type="search" placeholder="Search"
                                   aria-label="Search" onChange={this.handleSearch.bind(this)}/>
                            <GetAllCategories index={0} selectCallback={this.handleCategoryOption.bind(this)}/>
                        </form>
                    </div>
                    <div className="green-line"/>
                </div>
            )
        }
    }
    class Book extends React.Component {

        onClickHandler() {
            window.location.href = "bookProfile.jsp?id="+this.props.id
        }

        render() {
            return (
                <button className="m-1 p-2 border border-secondary rounded author-item" onClick={this.onClickHandler.bind(this)}>
                    { this.props.picture === ""
                    ? <img className="author-item-image" src="https://webstockreview.net/images/books-clipart-cute-4.png" width="150"></img>
                    : <img className="author-item-image" src={this.props.picture} width="150"></img>}
                    <br/>
                    <p className="author-item-name">{this.props.name}</p>
                </button>

            )
        }

    }
    class AllBooks extends React.Component {
        constructor() {
            super();
            this.getBooks = this.getBooks.bind(this)
            this.state = {
                books: []
            }
            this.getBooks()
        }

        getBooks() {
            const categoryUrl = new URLSearchParams(location.search)
            if (categoryUrl.get('category') !== null && categoryUrl.get('category') !== "") {
                var that = this
                var allBooks = []
                $.ajax({
                    url: 'get-books-by-category-servlet',
                    type: 'POST',
                    datatype: "json",
                    data: {
                        category: categoryUrl.get('category')
                    },
                    success: function (data) {
                        data.forEach(book => {
                            allBooks.push([book.book_id,book.name,book.picture])
                        })
                    },
                    complete: function () {
                        that.setState({
                            books: allBooks,
                        })
                    }
                })
            } else {
                var that = this
                var allBooks = []
                $.ajax({
                    url: 'get-books-servlet',
                    type: 'POST',
                    datatype: "json",
                    success: function (data) {
                        data.forEach(book => {
                            allBooks.push([book.book_id,book.name,book.picture])
                        })
                    },
                    complete: function () {
                        that.setState({
                            books: allBooks,
                        })
                    }
                })
            }

        }

        render() {
            return (
                <div className="d-flex flex-wrap ml-5 mr-5 mt-2">
                    {this.state.books.map((book) => {
                        if (book[1].toLowerCase().search(this.props.search.toLowerCase()) !== -1) {
                            return <Book key={book[0]} name={book[1]} id={book[0]} picture={book[2]}/>
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
                category: ''
            }
        }

        onChangeSearch = (search) => {
            this.setState({
                search: search
            })
        }

        categoryHandler = (category) => {
            this.setState({
                category: category
            })
        }

        render() {
            return (
                <div>
                    <SearchBar searchCallback={this.onChangeSearch} handleCategoryOption={this.categoryHandler}/>
                    <AllBooks search={this.state.search} category={this.state.category} />
                </div>
            )
        }
    }

    ReactDOM.render(<App/>, document.querySelector("#app"));
</script>

</body>
</html>
