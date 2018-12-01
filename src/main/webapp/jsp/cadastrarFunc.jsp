<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Funcionários</title>
        <link rel="stylesheet" href="./css/cadastrar-funcionario.css">
        <link rel="stylesheet" href="../css/cadastrar-funcionario.css">
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

        <section class="cadastro">
            <div class="container">
                <div class="cadastro">
                    <c:if test="${funcionario.getId() > 0}">
                        <h2 class="titulo-cad-func">Alterar Funcionário</h2>
                    </c:if>
                    <c:if test="${funcionario.getId() == 0}">
                        <h2 class="titulo-cad-func">Cadastro de Funcionário</h2>
                    </c:if> 
                    <c:if test="${funcionario == null}">
                        <h2 class="titulo-cad-func">Cadastro de Funcionário</h2>
                    </c:if> 
                    <form action="${pageContext.request.contextPath}/FuncCadastrar" method="post">  
                        <div class="labels-dados">
                            <label for="nome">Nome</label>
                            <label for="documento">Documento</label>
                            <label for="data-nascimento">Data de Nascimento</label>
                            <label for="sexo">Sexo</label>
                            <label for="nacionalidade">Nacionalidade</label>                        
                        </div><!--labels-->

                        <div class="inputs-dados">
                            <input type="hidden" name="id" value="${funcionario.getId()}" required>                        
                            <input type="name" name="nome" placeholder="Digite o nome" maxlength="100"  value="${funcionario.getNome()}" required><br>
                            <input type="text" name="NrDocumento" placeholder="Digite o numero de documento" maxlength="30" value="${funcionario.getNumDocumento()}" required><br>
                            <input type="date" name="data-nascimento" value="${funcionario.getDataNasci()}" required><br>                               
                            <select name="sexo" id="sexo" value="${funcionario.getSexo()}">
                                <option value="Masculino">Masculino</option>
                                <option value="Feminino">Feminino</option>
                                <option value="Outros">Outros</option>
                            </select><br>        
                            <input type="text" name="nacionalidade" placeholder="Digite a nacionalidade" maxlength="2" value="${funcionario.getNacionalidade()}" required><br>                        
                        </div><!--inputs-->

                        <div class="labels-endereco">
                            <label for="endereco">Endereço</label>
                            <label for="bairro">Bairro</label>
                            <label for="cidade">Cidade</label>
                            <label for="UF">UF</label>
                            <label for="cep">CEP</label>
                        </div><!--labels-->

                        <div class="inputs-endereco">
                            <input type="text" name="endereco" placeholder="Digite o endereço" maxlength="120" value="${funcionario.getEndereco()}" required><br>
                            <input type="text" name="bairro" placeholder="Digite o bairro" maxlength="60" value="${funcionario.getBairro()}" required><br>
                            <input type="text" name="cidade" placeholder="Digite a cidade" maxlength="80" value="${funcionario.getCidade()}" required><br>
                            <input type="text" name="uf" placeholder="Digite o estado" maxlength="2" value="${funcionario.getUf()}" required><br>  
                            <input type="text" name="cep" placeholder="Digite o CEP" maxlength="9" value="${funcionario.getCep()}" required> 
                        </div><!--inputs-->

                        <div class="labels-contato">           
                            <label for="email">E-mail</label>
                            <label for="telefone">Telefone</label>
                            <label for="cargo">Cargo</label>
                            <label for="departamento">Departamento</label>
                            <label for="numero-registro">N° Registro</label>
                        </div><!--labels-->

                        <div class="inputs-contato">                                                  
                            <input type="email" name="email" id="email" placeholder="Digite o e-mail" value="${funcionario.getEmail()}" required><br>
                            <input type="tel" name="telefone" id="telefone" placeholder="Digite o telefone" value="${funcionario.getTelefone()}" required><br>
                            <select name="cargo" id="cargo">
                                <option value="gerente">Gerente</option>
                                <option value="backoffice">Backoffice</option>
                            </select>                        
                            <input type="text" name="departamento" id="departamento" placeholder="Digite o departamento" value="${funcionario.getDepartamento()}" required><br>
                            <input type="number" name="numero-registro" id="numero-registro" placeholder="Digite o RE" value="${funcionario.departamento}" required>
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
