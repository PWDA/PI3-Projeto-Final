<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Relatório Global</title>
        <link rel="stylesheet" href="./css/relatorio-global.css">
        <link rel="stylesheet" href="../css/relatorio-global.css">
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
        <section>
            <div class="container">
                <div class="form-relatorio-global">
                    <h1>Relatório / Venda regional</h1>
                    <form action="${pageContext.request.contextPath}/Relatorio-Regional" method="post">
                        <label for="de">De</label>
                        <input type="date" name="dt_inicial">
                        <label for="ate">Até</label>
                        <input type="date" name="dt_final">
                        <input type="submit" name="btnConsultar" value="Consultar">
                    </form>
                </div><!--form-relatorio-global-->
            </div><!--container-->
        </section>
        <section class="section-consultar">
            <div class="container">
                <div class="tabela-consultar">
                    <table class="table-consultar" border="1">
                        <tr>
                            <th>Empresa</th>
                            <th>Cod.Venda</th>
                            <th>Produto</th>
                            <th>Qtd. Comprada</th>
                            <th>Valor unitário</th>
                            <th>Valor total</th>
                            <th>Data compra</th>
                        </tr>
                         <c:forEach items="${relatorio}" var="rel" varStatus="stat">
                            <tr>
                                <td> <c:out value="${rel.getEmpresa()}"/> </td>
                                <td> <c:out value="${rel.getCodigo()}"/> </td>
                                <td> <c:out value="${rel.getProduto()}"/> </td>
                                <td> <c:out value="${rel.getQtdComprado()}"/> </td>
                                <td> <c:out value="${rel.getValorUnitario()}"/> </td>
                                <td> <c:out value="${rel.getValorTotal()}"/> </td>
                                <td> <c:out value="${rel.getDataCompra()}"/> </td>
                            </tr>
                        </c:forEach>    
                    </table> 
                </div><!--tabela-consultar-->
            </div><!--container-->
        </section><!--section-consultar-->
        <section class="faturado">
            <div class="container">
                <form action="">
                    <label for="faturado">Total faturado</label>
                    <c:forEach items="${relatorio}" var="rel" varStatus="stat">
                        <c:if test="${rel.getTotFaturado() != 0}">
                            <input type="text" name="total-faturado" value="${rel.getTotFaturado()}">
                        </c:if>
                    </c:forEach>                    
                    <input type="submit" name="btnGerar" value="Gerar">
                </form>
            </div><!--container-->
        </section><!--faturado-->

    </body>
</html>
