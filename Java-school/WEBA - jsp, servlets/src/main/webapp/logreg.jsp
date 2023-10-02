<%@ page import="sk.matejcik.SemestralnaPraca.User.UserChecker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="header.jsp" %>
</head>
<body>
<%@include file="navbar.jsp" %>

<%
    if (UserChecker.isUserLogged(request)) {
        response.sendRedirect("booksBrowse.jsp");
    }
%>
<div id="App">
</div>

<script type="text/babel">
    class Error extends React.Component {
        constructor(props) {
            super();

        }
        render() {
            return (
                <span className="logreg-error-text">
                    {this.props.error === ""
                        ? <span></span>
                        : <span><i className="fas fa-exclamation-triangle"></i>      {this.props.error}</span>
                    }
                </span>

            )
        }

    }
    class LogRegButtons extends React.Component {
        constructor(props) {
            super();
            this.handleChange = this.handleChange.bind(this);
        }
        handleChange(event) {
            this.props.parentCallback(event.target.value);
        }
        render() {
            return (
                <div className="btn-group btn-group-toggle logreg-toggle" data-toggle="buttons" onChange={this.handleChange}>
                    <label className="btn btn-success active">
                        <span className="logreg-toggle-input">
                            <input type="radio" name="options" id="option1" value="Login" defaultChecked/>Login
                        </span>
                    </label>
                    <label className="btn btn-success">
                <span className="logreg-toggle-input">
                    <input type="radio" name="options" id="option2" value="Register" />Register
                </span>
                    </label>
                </div>
            )
        }
    }
    class Login extends React.Component {
        constructor() {
            super();
            this.state = {
                email: '',
                password: '',
                errorMessage: ''
            }
        }
        handleName = (event) => {
            this.setState({
                email: event.target.value
            })
        }
        handlePassword = (event) => {
            this.setState({
                password: event.target.value
            })
        }
        handleClick() {
            var that = this
            $.ajax({
                url: 'login-user-servlet',
                type: 'POST',
                data: {
                    'email': this.state.email,
                    'password':this.state.password
                },
                success: function(data) {
                    var data = data.split(";");
                    if (data[0] === "e") {
                        that.setState({
                            errorMessage: data[1]
                        })
                    }
                    if (data[0] === "s") {
                        window.location.href = "booksBrowse.jsp";
                    }
                },
                error: function(data) {
                    console.log("No servlet connection!");
                }
            })
        }
        render() {
            return (
                <form className="logreg-form" action="" id="form">
                    <div className="textbox">
                        <i className="fas fa-user logreg-icon"/>
                        <input type="text" placeholder="Email" id="email" name="email" onChange={this.handleName.bind(this)}/>
                    </div>
                    <div className="textbox">
                        <i className="fas fa-unlock logreg-icon"/>
                        <input type="password" placeholder="Password" name="" defaultValue="" onChange={this.handlePassword.bind(this)}/>
                        <Error error={this.state.errorMessage}/>
                    </div>
                    <button className="logreg-button btn btn-outline-success" type="button" name="" onClick={this.handleClick.bind(this)}>Sign in</button>
                </form>
            )
        }
    }
    class Register extends React.Component {

        constructor() {
            super();
            this.state = {
                name: '',
                lastName: '',
                password: '',
                repeatPassword: '',
                email: '',
                nameErr: '',
                lastNameErr: '',
                passwordErr: '',
                repeatPasswordErr: '',
                emailErr: '',
                submitted: false
            }
        }

        handleChange(event) {
            this.setState({
                [event.target.name]: event.target.value
            }, () => {
                if (this.state.submitted) {
                    this.validate()
                }
            });
        }

        handleClick(event) {
            const isValid = this.validate()
            var that = this
            if (isValid) {
                $.ajax({
                    url: 'register-user-servlet',
                    type: 'POST',
                    data: {
                        'name': this.state.name,
                        'lastname': this.state.lastName,
                        'password':this.state.password,
                        'email':this.state.email
                    },
                    success: function(data) {
                        var data = data.split(";");
                        if (data[0] === "e") {
                            that.setState({
                                emailErr: data[1]
                            })
                        }
                        if (data[0] === "red") {
                                window.location.href = "error.jsp";
                        }
                        if (data[0] === "s") {
                            window.location.href = "booksBrowse.jsp";
                        }
                    },
                    error: function(data) {
                        console.log("No servlet connection!");
                    }
                })
            }
        }

        validate() {
            let nameError = "";
            let lastNameError = "";
            let passwordError = "";
            let repeatPasswordError = "";
            let emailError = "";
            let isValid = true;
            if (!this.state.name.length) {
                nameError = "Name cannot be blank";
                isValid = false;
            } else {
                if (this.state.name.length < 3 || this.state.name.length > 30) {
                    nameError = "Enter between 3-30 characters.";
                    isValid = false;
                }
            }
            if (!this.state.lastName.length) {
                lastNameError = "Last name cannot be blank";
                isValid = false;
            } else {
                if (this.state.lastName.length < 3 || this.state.lastName.length > 50) {
                    lastNameError = "Enter between 3-50 characters.";
                    isValid = false;
                }
            }
            if (!this.state.password.length) {
                passwordError = "Enter password"
                isValid = false;
            } else {
                if (this.state.password.length < 3 || this.state.password.length > 50) {
                    passwordError = "Enter between 3-50 characters.";
                    isValid = false;
                }
            }
            if (this.state.password !== this.state.repeatPassword) {
                repeatPasswordError = "Passwords are not the same!"
                isValid = false;
            }

            if (!this.state.email.length) {
                emailError = "Email cannot be blank";
                isValid = false;
            } else {
                if (!this.state.email.includes("@") || !this.state.email.includes(".")) {
                    emailError = "Enter valid email adress";
                    isValid = false;
                }
            }

            this.setState({
                nameErr: nameError,
                lastNameErr: lastNameError,
                passwordErr: passwordError,
                repeatPasswordErr: repeatPasswordError,
                emailErr:emailError,
                submitted: true
            })

            return isValid;

        }

        render() {
            return (
                <form className="logreg-form" action="" id="form">
                    <div className="textbox">
                        <i className="fas fa-user logreg-icon"></i>
                        <input type="text" placeholder="RegName" id="reg3" name="name" onChange={this.handleChange.bind(this)}/>
                        <Error error={this.state.nameErr}/>
                    </div>
                    <div className="textbox">
                        <i className="fas fa-user logreg-icon"></i>
                        <input type="text" placeholder="RegLastName" id="reg2" name="lastName" onChange={this.handleChange.bind(this)}/>
                        <Error error={this.state.lastNameErr}/>
                    </div>
                    <div className="textbox">
                        <i className="fas fa-unlock logreg-icon"></i>
                        <input type="password" placeholder="RegPass" name="password" defaultValue="" onChange={this.handleChange.bind(this)}/>
                        <Error error={this.state.passwordErr}/>
                    </div>
                    <div className="textbox">
                        <i className="fas fa-unlock logreg-icon"></i>
                        <input type="password" placeholder="RegPassRepeat" name="repeatPassword" defaultValue="" onChange={this.handleChange.bind(this)}/>
                        <Error error={this.state.repeatPasswordErr}/>
                    </div>
                    <div className="textbox">
                        <i className="fas fa-envelope logreg-icon"></i>
                        <input type="email" placeholder="Email" id="reg1" name="email" onChange={this.handleChange.bind(this)}/>
                        <Error error={this.state.emailErr}/>
                    </div>
                    <button className="logreg-button btn btn-outline-success" type="button" name="" onClick={this.handleClick.bind(this)}>Sign in</button>
                </form>
            )
        }
    }
    class App extends React.Component {

        constructor() {
            super();
            this.state = {
                logreg: 'Login'
            }
        }

        onChangeName = (name) => {
            this.setState({
                logreg: name
            })
        }

        render() {
            return (
                <div className="logreg-container">
                    <LogRegButtons parentCallback={this.onChangeName}/>
                    {this.state.logreg === "Login"
                        ? <Login/>
                        : <Register/>
                    }
                </div>
                )
        }
    }

    ReactDOM.render(<App/>, document.querySelector("#app"));
</script>

</body>
</html>
