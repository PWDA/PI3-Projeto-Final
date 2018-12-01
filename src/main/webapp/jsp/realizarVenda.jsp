<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Venda</title>  
        <link rel="stylesheet" href="./css/realizar-venda.css">
        <link rel="stylesheet" href="../css/realizar-venda.css">
        <!--google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,700" rel="stylesheet">

        <!--fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

        <!--
        <script type="text/javascript">     
            function Atualizar(){
                window.location.reload();
                
                onload="setInterval('Atualizar()', 5000)"
            }    
        </script>
        -->

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
        <section class="venda">
            <div class="container">
                <div class="aside">
                    <h2 class="chamada-venda">Agora é a hora de realizar a venda!</h2>
                    <div class="container-venda">                    
                        <form method="post">                        
                            <input type="hidden" name="id" value="${produto.getId()}" >                         
                            Qtd<input type="number" name="quantidadeVenda" placeholder="Quantidade..." value="${produto.getQtdProd()}" >
                            Nome<input type="text" name="vendaProduto" placeholder = "Produto..." value="${produto.getProduto()}" value="${buscar}" >
                            Valor Unitário<input type="text" name="valorUnitario" value="${produto.getValorUnitario()}" >
                            <input type="text" name="valorTotal">                        
                            <input type="submit" name="btnCarregar" value="Carregar" formaction="CarregarProd">                      
                            <input type="submit" name="btnIncluir" value="Incluir" formaction="IncluirProd" >                                                           
                        </form>                                                  

                        <div class="listar-venda">

                            <table>
                                <tr>
                                    <th>ID</th>
                                    <th>Qtd</th>
                                    <th>Produto</th>
                                    <th>Valor unitário</th>
                                    <th>Valor total</th>
                                </tr>

                                <c:forEach items="${listaProduto}" var="prod" varStatus="stat">
                                    <tr>
                                        <td> <c:out value="${prod.getId()}"/> </td>
                                        <td> <c:out value="${prod.getQtdProd()}"/> </td>
                                        <td> <c:out value="${prod.getProduto()}"/> </td>                                                                                    
                                        <td> <c:out value="${prod.getValorUnitario()}"/> </td>
                                        <td> <c:out value="${prod.getValorTotal()}"/> </td>                            
                                        <td> 
                                            <a href="###?id=<c:out value='${prod.getId()}'/>" 
                                               class="btn-alterar"> <i class="fas fa-pencil-alt"> </i> </a>
                                        </td>

                                        <td>
                                            <a href="DeleteVenda?id=<c:out value='${prod.getId()}'/>" 
                                               class="btn-delete"> <i class="fas fa-times"> </i> </a>
                                        </td>
                                    </tr>
                                </c:forEach>


                            </table>
                            <form class="confirmar" action="">
                                <label for="">SUBTOTAL:</label>
                                <input class="campo-subtotal" type="text" name="subtotal" value="${subtotal}">
                                <input type="submit" name="btn-subtotal" value="Confirmar">
                            </form>
                        </div><!--listar-venda-->
                    </div><!--container-venda-->
                </div>
                <div class="aside-right">

                </div>
            </div><!--container-->
        </section><!--venda-->
    </body>
</html>
