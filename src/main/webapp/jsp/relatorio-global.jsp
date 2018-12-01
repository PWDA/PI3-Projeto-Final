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
                                        <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/EmpConsultar" method="get">Relatório Global</a></li>
                                        </c:if>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/CliConsultar" method="get">Relatório Regional</a></li>
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
                    <h1>Relatório / Venda global</h1>

                    <form action="">
                        <label for="filial">Filial</label>
                        <select name="filial" id="filial">
                            <option value="selecione">Selecione</option>
                            <option value="semana1">São Paulo</option>
                            <option value="semana2">Campina Grande</option>
                            <option value="semana3">Brasília</option>
                            <option value="semana4">Joinville</option>
                        </select><br>

                        <label for="periodo">Período</label>
                        <select name="periodo" id="periodo">
                            <option value="selecione">Selecione</option>
                            <option value="semana1">1º Semana</option>
                            <option value="semana2">2º Semana</option>
                            <option value="semana3">3º Semana</option>
                            <option value="semana4">4º Semana</option>
                        </select>
                        <input type="checkbox" name="check-periodo">
                        <label for="escolher-periodo">Escolher período</label><br>
                        <label for="de">De</label>
                        <input type="date" name="date-de">
                        <label for="ate">Até</label>
                        <input type="date" name="ate">
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
                            <th>Código</th>
                            <th>Produto</th>
                            <th>Qtd. Comprada</th>
                            <th>Valor unitário</th>
                            <th>Valor total</th>
                            <th>Data compra</th>
                        </tr>
                        <tr>
                            <td>4324</td>
                            <td>Sopinha</td>
                            <td>50</td>
                            <td>3,00</td>
                            <td>150,00</td>
                            <td>23/01/1993</td>
                        </tr>
                        <tr>
                            <td>4324</td>
                            <td>Sopinha</td>
                            <td>50</td>
                            <td>3,00</td>
                            <td>150,00</td>
                            <td>23/01/1993</td>
                        </tr>
                        <tr>
                            <td>4324</td>
                            <td>Sopinha</td>
                            <td>50</td>
                            <td>3,00</td>
                            <td>150,00</td>
                            <td>23/01/1993</td>
                        </tr>
                        <tr>
                            <td>4324</td>
                            <td>Sopinha</td>
                            <td>50</td>
                            <td>3,00</td>
                            <td>150,00</td>
                            <td>23/01/1993</td>
                        </tr>
                        <tr>
                            <td>4324</td>
                            <td>Sopinha</td>
                            <td>50</td>
                            <td>3,00</td>
                            <td>150,00</td>
                            <td>23/01/1993</td>
                        </tr>     
                    </table> 
                </div><!--tabela-consultar-->
            </div><!--container-->
        </section><!--section-consultar-->
        <section class="faturado">
            <div class="container">
                <form action="">
                    <label for="faturado">Total faturado</label>
                    <input type="text" name="total-faturado">
                    <input type="submit" name="btnGerar" value="Gerar">
                </form>
            </div><!--container-->
        </section><!--faturado-->

    </body>
</html>
