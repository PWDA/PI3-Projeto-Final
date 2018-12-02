<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Cliente</title>
        <link rel="stylesheet" href="./css/cadastrar-cliente.css">
        <link rel="stylesheet" href="../css/cadastrar-cliente.css">
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
        <section class="cadastro">
            <div class="container">
                <div class="cadastro">
                    <c:if test="${cliente.getId() > 0}">
                        <h2 class="titulo-cad-func">Alterar Cliente</h2>
                    </c:if>
                    <c:if test="${cliente.getId() == 0}">
                        <h2 class="titulo-cad-func">Cadastro de Cliente</h2>
                    </c:if> 
                    <c:if test="${cliente == null}">
                        <h2 class="titulo-cad-func">Cadastro de Cliente</h2>
                    </c:if>
                    <c:out value="${erro}"/>
                    <form action="${pageContext.request.contextPath}/CliCadastrar" method="post">  
                        <div class="labels-dados">
                            <label for="nome">Nome</label>
                            <label for="documento">Documento</label>                        
                            <label for="sexo">Sexo</label>
                            <label for="email">E-mail</label>
                            <label for="telefone">Telefone</label>
                            <label for="tagPessoa">Pessoa (CPF/CNPJ)</label>                        
                        </div><!--labels-->

                        <div class="inputs-dados">
                            <input type="hidden" name="id" value="${cliente.getId()}" required> 
                            <input type="name" name="nome" id="nome" placeholder="Digite o nome" value="${cliente.getNome()}" required><br>
                            <input type="text" name="NrDocumento" id = "documento" placeholder="Digite o documento" value="${cliente.getNumDocumento()}" required><br>                            
                            <select name="sexo" id="sexo" value="${cliente.getSexo()}">
                                <option value="Masculino">Masculino</option>
                                <option value="Feminino">Feminino</option>
                                <option value="Outros">Outros</option>
                            </select>
                            <input type="email" name="email" id="email" placeholder="Digite o e-mail" value="${cliente.getEmail()}" required><br>
                            <input type="tel" name="telefone" id="telefone" placeholder="Digite o telefone" value="${cliente.getTelefone()}" required><br>                                
                            <input type="text" name="tagPessoa" placeholder="F=Física / J=Jurídica" maxlength="1" value="${cliente.getTagPessoa()}"  required><br>
                        </div><!--inputs-->

                        <div class="labels-endereco">
                            <label for="endereco">Endereço</label>
                            <label for="bairro">Bairro</label>
                            <label for="cidade">Cidade</label>
                            <label for="UF">UF</label>
                            <label for="cep">CEP</label>
                        </div><!--labels-->

                        <div class="inputs-endereco">
                            <input type="text" name="endereco" id="endereco" placeholder="Digite o endereço" value="${cliente.getEndereco()}" required><br>
                            <input type="text" name="bairro" id="bairro" placeholder="Digite o bairro" value="${cliente.getBairro()}" required><br>
                            <input type="text" name="cidade" id="cidade" placeholder="Digite a cidade" value="${cliente.getCidade()}" required><br>
                            <input name="uf" id="UF" placeholder="Digite o estado" maxlength="2" value="${cliente.getUf()}" required><br>  
                            <input type="text" name="cep" id="cep" placeholder="Digite o CEP" value="${cliente.getCep()}" required>
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
