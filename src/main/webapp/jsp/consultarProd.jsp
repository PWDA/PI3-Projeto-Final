<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Consultar Produtos</title>
        <link rel="stylesheet" href="./css/consultar-produto.css">
        <link rel="stylesheet" href="../css/consultar-produto.css">
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
                            <c:if test="${usuario.getAutorizar() == 1 || usuario.getAutorizar() == 2}">
                            <li class="link-submenu-cadastro"><a href="#">Cadastro</a>
                                <ul class="sub-menu">
                                    <c:if test="${usuario.getAutorizar() == 2}">
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
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/ProdConsultar" method="get">Produto</a></li>
                                </ul>
                            </li>
                            <li class="link-submenu-consulta"><a href="#">Relatórios</a>
                                <ul class="sub-menu">
                                    <c:if test="${usuario.getAutorizar() == 2}">
                                        <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Global" method="get">Relatório Global</a></li>
                                        </c:if>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Regional" method="get">Relatório Regional</a></li>
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

                <form action="${pageContext.request.contextPath}/ProdConsultar" method="post">
                    <h1>Consulta de Produtos</h1>                                                
                    <input type="text" name="buscar" placeholder="Digite para buscar..." value="${buscar}">
                    <lable for="situacao">Situação</lable>
                    <select name="situacao" id="situacao">
                        <option value="Ativos">Ativos</option>
                        <option value="Inativos">Inativos</option>
                        <option value="Todos">Todos</option>                     
                    </select>
                    <input type="submit" name="btn-buscar" value="Buscar">

                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Produto</th>
                            <th>Tipo Produto</th>
                            <th>Quantidade</th>
                            <th>Origem</th>
                            <th>Valor Unitário</th>
                            <th>Descricao</th>

                        </tr>

                        <c:forEach items="${produto}" var="prod" varStatus="stat">
                            <tr>
                                <td> <c:out value="${prod.getId()}"/> </td>
                                <td> <c:out value="${prod.getProduto()}"/> </td>
                                <td> <c:out value="${prod.getTipoProd()}"/> </td>
                                <td> <c:out value="${prod.getQtdProd()}"/> </td>
                                <td> <c:out value="${prod.getOrigem()}"/> </td>
                                <td> <c:out value="${prod.getValorUnitario()}"/> </td>
                                <td> <c:out value="${prod.getDescricao()}"/> </td>
                                <td> 
                                    <a href="ProdCadastrar?id=<c:out value='${prod.getId()}'/>" 
                                       class="btn-alterar"> <i class="fas fa-pencil-alt"> </i> </a>
                                </td>

                                <td>
                                    <a href="ProdDeletar?id=<c:out value='${prod.getId()}'/>" 
                                       class="btn-delete"> <i class="fas fa-times"> </i> </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <tr>
                            <td> <a href="ProdCadastrar?action=doGet" class="btn-incluir">Novo cadastro</a ></td>
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
