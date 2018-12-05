<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Login PWDA</title>
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="../css/style.css">

        <!--google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,700" rel="stylesheet">

        <!--fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">


    </head>
    <body>
        <header>
            <div class="container">
                <nav>
                    <div class="logo"><br>
                        <a href="index.html"><img src="./img/pwda-logo.png" alt="" width="200"></a>   
                    </div><!--logo-->
                </nav>
            </div><!--container--> 
        </header>
        <section class="section-login">

            <div class="login">                
                <h2 class="text-logar">Login</h2>                  

                <form method="post" action="${pageContext.request.contextPath}/Login">
                    <input type="text" name="login" id="user" placeholder="usuário">
                    <input type="password" name="senha" id="pass" placeholder="senha"><br><br>     
                    <input class="btn-login" type="submit" name="btn-logar" value="Entrar"><br><br><br><br>
                    <c:out value="${msgErro}"/>
                </form>
            </div><!--login--> 


        </section>
    </body>
</html>