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
                    <c:if test="${produto.getId() > 0}">
                        <h2 class="titulo-cad-func">Alterar Produto</h2>
                    </c:if>
                    <c:if test="${produto.getId() == 0}">
                        <h2 class="titulo-cad-func">Cadastro de Produto</h2>
                    </c:if> 
                    <c:if test="${produto == null}">
                        <h2 class="titulo-cad-func">Cadastro de Produto</h2>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/ProdCadastrar" method="post">  
                        <div class="labels-dados">
                            <label for="nome">Nome</label>
                            <label for="tipo-ativo">Tipo de Produto</label>
                            <label for="quantidade">Quantidade</label>
                            <label for="origem">Origem</label>
                            <label for="valor-unitario">Valor Unitário</label>
                            <label for="descricao">Descrição</label>                        
                        </div><!--labels-->

                        <div class="inputs-dados">
                            <input type="hidden" name="id" value="${produto.getId()}" required>                        
                            <input type="name" name="nome-produto" placeholder="Digite o nome do produto" maxlength="100"  value="${produto.getProduto()}" required><br>
                            <select name="tipo-ativo" id="tipo-ativo">
                                <c:if test="${produto.getTipoProd()} == 'Ativo Fixo'">
                                    <option value="Ativo Fixo">Ativo Fixo</option>
                                    <option value="Ativo Circulante">Ativo Circulante</option>
                                    <option value="Outros">Outros</option>
                                </c:if>
                                <c:if test="${produto.getTipoProd()} == 'Ativo Circulante'">
                                    <option value="Ativo Circulante">Ativo Circulante</option>
                                    <option value="Ativo Fixo">Ativo Fixo</option>
                                    <option value="Outros">Outros</option>
                                </c:if>
                                  
                            </select>
                            <input type="number" name="qtd" value="${produto.getQtdProd()}" required><br> 
                            <input type="text" name="origem" placeholder="Digite a origem" value="${produto.getOrigem()}" required><br> 
                            <input type="float" name="valor-unitario" placeholder="Digite o valor" maxlength="10" value="${produto.getValorUnitario()}" required><br>
                            <input type="text" name="descricao" placeholder="Digite a descrição" maxlength="100" value="${produto.getDescricao()}"  required><br>                        
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
