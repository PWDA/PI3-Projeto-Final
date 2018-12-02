<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="./css/cadastro-login.css">
        <link rel="stylesheet" href="../css/cadastro-login.css">
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
                <div class="cadastro-login">
                    <c:if test="${login.getId() > 0}">
                        <h2 class="titulo-cad-func">Alterar Login</h2>
                    </c:if>
                    <c:if test="${login.getId() == 0}">
                        <h2 class="titulo-cad-func">Cadastro de Login</h2>
                    </c:if>
                    <c:if test="${login == null}">
                        <h2 class="titulo-cad-func">Cadastro de Login</h2>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/LoginCadastrar" method="post">
                        <input type="hidden" name="id" value="${login.getId()}" required>
                        <input type="hidden" name="idFunc" value="${login.getFunc()}" required> 
                        <label for="user">Usuário</label><br>
                        <input type="text" name="user" id="user" placeholder="Digite o nome de usuário" maxlength="150"  value="${login.getLogin()}" required><br>
                        <label for="password">Senha</label><br>
                        <input type="text" name="password" id="password" placeholder="Digite a Senha" maxlength="150" value="${login.getSenha()}" required><br>
                        <label for="permissao">Permissão</label><br>
                        <input type="text" name="permissao" id="permissao" placeholder="Digite a permissão de acesso" maxlength="60" value="${login.getPermissao()}" required><br> 
                        <label for="empresa">Empresa</label><br>
                        <input type="text" name="empresa" id="empresa" placeholder="Digite a empresa" maxlength="60" value="${login.getEmpresa()}"  required><br>
                        <!--<select name="${login.getEmpresa()}" id="empresa">
                            <option value="PWDA SAO PAULO" >PWDA SÃO PAULO</option>
                            <option value="PWDA RIO DE JANEIRO">PWDA RIO DE JANEIRO</option>
                            <option value="PWDA SALVADOR">PWDA SALVADOR</option>
                        </select>-->
                        <input type="submit" name="btn-cadastrar-login" value="Cadastrar">

                        <c:out value="${msgErro}"/><br>
                    </form>
                </div><!--cadastro-login-->
            </div><!--container-->
        </section>  
    </body>
</html>
