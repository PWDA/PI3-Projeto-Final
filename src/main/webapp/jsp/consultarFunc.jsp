<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Funcionários</title>
        <link rel="stylesheet" href="./css/consultar-funcionario.css">
        <link rel="stylesheet" href="../css/consultar-funcionario.css">
        <!--google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,700" rel="stylesheet">

        <!--fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
    </head>
    <body> 
        <c:if test="${usuario.getId() == null}">
            <c:redirect url="http://localhost:8080/br.com.senac.pi3.pwda/Login?code=00" />            
        </c:if>
        <header>
            <nav>
                <div class="top-header">
                    <div class="container">
                        <a href="./jsp/home.jsp">
                            <img class="img-logo" src="../img/pwda-logo.png" alt="" width="200">
                            <img class="img-logo" src="./img/pwda-logo.png" alt="" width="200">
                        </a> 
                    </div><!--container-->
                </div><!--logo-->
                <div class="container">
                    <ul class="menu-principal">
                        <li><a href="./jsp/home.jsp">Home</a></li>
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
                        <li><a href="${pageContext.request.contextPath}realizar-venda.jsp">Realizar Venda</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
                    </ul>
                </div><!--container-->
            </nav>    
        </header>                    

        <div class="wrap">
            <div class="container">

                <input type="hidden" value="${erro}" id="erroMsg" name="erroMsg" />

                <form action="${pageContext.request.contextPath}/FuncConsultar" method="post">
                    <h1>Consulta de Funcionários</h1>                                                
                    <input type="text" name="buscar" placeholder="Digite para buscar..." value="${buscar}">
                    <label for="situacao">Situação</label>
                    <select name="situacao" id="situacao">
                        <option value="Ativos">Ativos</option>
                        <option value="Inativos">Inativos</option>
                        <option value="Todos">Todos</option>
                    </select>
                    <input type="submit" name="btn-buscar" value="Buscar">

                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>E-mail</th>
                            <th>Telefone</th>
                            <th>Cargo</th>
                            <th>Departamento</th>
                            <th>Alterar</th>
                                <c:if test="${usuario.getAutorizar() == 4 || usuario.getAutorizar() == 2}">
                                <th>Inativar/Ativar</th>
                                </c:if>
                                <c:if test="${usuario.getAutorizar() == 4}">
                                <th>Login</th>
                                </c:if>
                        </tr>

                        <c:forEach items="${funcionario}" var="func" varStatus="stat">
                            <tr>
                                <td> <c:out value="${func.getId()}"/> </td>
                                <td> <c:out value="${func.getNome()}"/> </td>
                                <td> <c:out value="${func.getEmail()}"/> </td>
                                <td> <c:out value="${func.getTelefone()}"/> </td>
                                <td> <c:out value="${func.getCargo()}"/> </td>
                                <td> <c:out value="${func.getDepartamento()}"/> </td>
                                <td> 
                                    <a href="FuncCadastrar?id=<c:out value='${func.getId()}'/>" 
                                       class="btn-alterar"> <i class="fas fa-pencil-alt"> </i> </a>
                                </td>
                                <c:if test="${usuario.getAutorizar() == 4 || usuario.getAutorizar() == 2}">
                                    <td>
                                        <a href="FuncDeletar?id=<c:out value='${func.getId()}'/>" 
                                           class="btn-delete"> <i class="fas fa-times"> </i> </a>
                                    </td>
                                </c:if>
                                <c:if test="${usuario.getAutorizar() == 4}">
                                    <td>
                                        <a href="LoginCadastrar?id=<c:out value='${func.getId()}'/>" 
                                           class="btn-criarLogin"> <i class="fas fa-user-plus"> </i> </a>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>

                        <tr>                        
                            <td> <a href="FuncCadastrar?action=doGet" class="btn-incluir">Novo cadastro</a></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

        <footer>
            <p>Desenvolvido por PWDA - 2018</p>
            <p>Todos os direitos reservados</p>
        </footer>

    </body>
</html>
