<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Cadastro de Produtos</title>
        <link rel="stylesheet" href="./css/cadastro-login.css">
        <link rel="stylesheet" href="../css/cadastrologin.css">
        <!--google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,700" rel="stylesheet">

        <!--fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
    </head>
    <body>  

        <header>
            <nav>
                <div class="top-header">
                    <div class="container">
                        <a href="./jsp/home.jsp">
                            <img class="img-logo" src="./img/pwda-logo.png" alt="" width="200">
                        </a> 
                    </div><!--container-->
                </div><!--logo-->
                <div class="container">
                    <ul class="menu-principal">
                        <li><a href="../jsp/home.jsp">Home</a></li>
                        <li class="link-submenu-cadastro"><a href="#">Cadastro</a>
                            <ul class="sub-menu">
                                <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/EmpCadastrar" method="get">Empresa</a></li>
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
                        <li><a href="${pageContext.request.contextPath}realizarVenda.html">Realizar Venda</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
                    </ul>
                </div><!--container-->
            </nav>     
        </header>                            

        <section class="cadastro">
            <div class="container">
                <div class="cadastro">
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
                        <div class="labels-dados">
                            <label for="login">Login</label>
                            <label for="senha">Senha</label>
                            <label for="permissao">Permissão</label>
                            <label for="empresa">Empresa</label>                      
                        </div><!--labels-->

                        <div class="inputs-dados">
                            <input type="hidden" name="id" value="${login.getId()}" required>
                            <input type="hidden" name="idFunc" value="${login.getFunc()}" required> 
                            <input type="text" name="login" placeholder="Digite o login" maxlength="150"  value="${login.getLogin()}" required><br>
                            <input type="text" name="senha" placeholder="Digite a Senha" maxlength="150" value="${login.getSenha()}" required><br>
                            <input type="text" name="permissao" placeholder="Digite a permissão de acesso" maxlength="60" value="${login.getPermissao()}" required><br> 
                            <input type="text" name="empresa" placeholder="Digite a empresa" maxlength="60" value="${login.getEmpresa()}"  required><br>
                            <c:out value="${msgErro}"/><br>
                            <input type="submit" name="cadastrar" value="Cadastrar">
                        </div><!--inputs-->                                   

                    </form>
                </div><!--cadastro-->
            </div><!--container-->
        </section>


        <footer>
            <p>Desenvolvido por PWDA - 2018</p>
            <p>Todos os direitos reservados</p>
        </footer>

    </body>
</html> 
