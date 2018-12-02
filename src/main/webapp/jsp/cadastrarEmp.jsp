<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Cadastro de Produtos</title>
        <link rel="stylesheet" href="./css/cadastrar-produto.css">
        <link rel="stylesheet" href="../css/cadastrar-produto.css">
        <!--google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,700" rel="stylesheet">

        <!--fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
    </head>
    <body>
        <c:if test="${usuario.getAutorizar() != 2}">
            <c:redirect url=" http://localhost:8080/br.com.senac.pi3.pwda/jsp/home.jsp" />            
        </c:if>
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

        <section class="cadastro">
            <div class="container">
                <div class="cadastro">
                    <c:if test="${empresa.getId() > 0}">
                        <h2 class="titulo-cad-func">Alterar Empresa</h2>
                    </c:if>
                    <c:if test="${empresa.getId() == 0}">
                        <h2 class="titulo-cad-func">Cadastro de Empresa</h2>
                    </c:if> 
                    <c:if test="${empresa == null}">
                        <h2 class="titulo-cad-func">Cadastro de Empresa</h2>
                    </c:if>
                    <div aling="center">
                        <c:out value="${erro}"/>
                    </div>

                    <form action="${pageContext.request.contextPath}/EmpCadastrar" method="post">  
                        <div class="labels-dados">
                            <label for="empresa">Empresa</label>
                            <label for="diretor">Diretor</label>
                            <label for="cnpj">CNPJ</label>
                            <label for="endereco">Endereço</label>
                            <label for="bairro">Bairro</label>                      
                            <label for="cidade">Cidade</label>                      
                            <label for="uf">UF</label>                      
                            <label for="cep">Cep</label>                      
                            <label for="telefone">Telefone</label>                      
                            <label for="email">E-mail</label>                 
                        </div><!--labels-->

                        <div class="inputs-dados">
                            <input type="hidden" name="id" value="${emp.getId()}" required>
                            <input type="text" name="empresa" placeholder="Digite o nome da empresa" maxlength="80"  value="${emp.getEmpresa()}" required><br>
                            <input type="text" name="diretor" placeholder="Digite o nome do diretor" maxlength="80" value="${emp.getDiretor()}" required><br>
                            <input type="text" name="cnpj" placeholder="Digite o CNPJ da empresa" maxlength="30" value="${emp.getCnpj()}" required><br> 
                            <input type="text" name="endereco" placeholder="Digite o endereço" maxlength="120" value="${emp.getEndereco()}"  required><br>
                            <input type="text" name="bairro" placeholder="Digite o bairro" maxlength="60" value="${emp.getBairro()}"  required><br>
                            <input type="text" name="cidade" placeholder="Digite a cidade" maxlength="60" value="${emp.getCidade()}"  required><br>
                            <input type="text" name="uf" placeholder="Digite o UF" maxlength="2" value="${emp.getUf()}"  required><br>
                            <input type="text" name="cep" placeholder="Digite o CEP" maxlength="9" value="${emp.getCep()}"  required><br>
                            <input type="text" name="telefone" placeholder="Digite o telefone" maxlength="80" value="${emp.getTelefone()}"  required><br>
                            <input type="email" name="email" placeholder="Digite o e-mail" maxlength="150" value="${emp.getEmail()}"  required><br>
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
