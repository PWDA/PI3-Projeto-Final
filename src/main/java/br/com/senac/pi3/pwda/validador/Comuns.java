package br.com.senac.pi3.pwda.validador;

import br.com.senac.pi3.pwda.model.Login;

public class Comuns {
     private static Login usuarioLogado;

    public static Login getUsuarioLogado() {
        return usuarioLogado;
    }

    public static void setUsuarioLogado(Login usuarioLogado) {
        Comuns.usuarioLogado = usuarioLogado;
    }
     
     
}
