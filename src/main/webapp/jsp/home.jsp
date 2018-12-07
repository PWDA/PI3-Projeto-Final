<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="./css/home.css">
        <link rel="stylesheet" href="../css/home.css">
        <!--google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,700" rel="stylesheet">

        <!--fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
    </head>
    <body>
        <c:if test="${usuario.getId() == null}">
            <c:redirect url="http://localhost:8080/br.com.senac.pi3.pwda/Login?code=00" />
        </c:if>
        <c:if test="${usuario.getInativo() == 1}">
            <c:redirect url="http://localhost:8080/br.com.senac.pi3.pwda/Login?code=XX" />
        </c:if>
        <header>
            <nav>
                <div class="top-header">
                    <div class="container">
                        <a href="../jsp/home.jsp">
                            <img class="img-logo" src="../img/pwda-logo.png" alt="" width="200">
                            <img class="img-logo" src="./img/pwda-logo.png" alt="" width="200">
                        </a>
                    </div><!--container-->
                </div><!--logo-->
                <div class="container">
                    <ul class="menu-principal">
                        <li><a href="../jsp/home.jsp">Home</a></li>
                            <c:if test="${usuario.getAutorizar() == 1 || usuario.getAutorizar() == 2 || usuario.getAutorizar() == 4 || usuario.getAutorizar() == 3}">
                            <li class="link-submenu-cadastro"><a href="#">Cadastro</a>
                                <ul class="sub-menu">
                                    <c:if test="${usuario.getAutorizar() == 2 || usuario.getAutorizar() == 4}">
                                        <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/EmpCadastrar" method="get">Empresa</a></li>
                                        </c:if>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/CliCadastrar" method="get">Cliente</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/FuncCadastrar" method="get">Funcionário</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/ProdCadastrar" method="get">Produto</a></li>
                                </ul>
                            </li>
                            <li class="link-submenu-consulta"><a href="#">Consultar</a>
                                <ul class="sub-menu">
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/EmpConsultar" method="get">Empresa</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/CliConsultar" method="get">Cliente</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/FuncConsultar" method="get">Funcionário</a></li>
                                        <c:if test="${usuario.getAutorizar() == 2 || usuario.getAutorizar() == 1 || usuario.getAutorizar() == 3 || usuario.getAutorizar() == 4 || usuario.getAutorizar() == 5}">
                                        <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/ProdConsultar" method="get">Produto</a></li>
                                        </c:if>
                                </ul>
                            </li>
                            <li class="link-submenu-consulta"><a href="#">Relatórios</a>
                                <ul class="sub-menu">
                                    <c:if test="${usuario.getAutorizar() == 2 || usuario.getAutorizar() == 4}">
                                        <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Global" method="get">Relatório Global</a></li>
                                        </c:if>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Regional" method="get">Relatório Regional</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Produto" method="get">Relatório Produto</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Cliente" method="get">Relatório Cliente</a></li>
                                </ul>
                            </li>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}/Caixa">Realizar Venda</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
                    </ul>
                </div><!--container-->
            </nav>
        </header>

        <section>
            <div class="container">
                <div class="bem-vindos">
                    <h2>Sejam Bem vindos ao</h2>
                    <h1 class="title-pwda">PWDA</h1>
                </div><!--bem-vindos-->
            </div>

        </section>

    </body>
</html>
