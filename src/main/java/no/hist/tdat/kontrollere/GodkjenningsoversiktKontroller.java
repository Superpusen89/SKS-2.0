package no.hist.tdat.kontrollere;

import no.hist.tdat.javabeans.Bruker;
import no.hist.tdat.javabeans.DelEmne;
import no.hist.tdat.javabeans.Emne;
import no.hist.tdat.javabeans.Oving;
import no.hist.tdat.javabeans.beanservice.BrukerService;
import no.hist.tdat.javabeans.beanservice.EmneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 * Created by vimCnett
 */

@Controller
public class GodkjenningsoversiktKontroller {
    @Autowired
    BrukerService service;
    @Autowired
    EmneService service2;

    @RequestMapping(value = "hentRiktigEmne", method = RequestMethod.POST)  //kalles av ajax
    public void hentRiktigEmne(HttpServletRequest request, HttpSession session) {
        String emne = request.getParameter("emne");

        ArrayList<Bruker> alle = service.finnStudenterIDelemne(emne);   //alle med faget

        for (int i = 0; i < alle.size(); i++) {
            ArrayList<Emne> em = new ArrayList<Emne>();
            ArrayList<DelEmne> a = new ArrayList<DelEmne>();

            Bruker br = alle.get(i);
            ArrayList<Oving> ovinger = service.hentOvinger(emne); //henter �vinger til delemnet

            ArrayList<Oving> godkj = service.hentGodkjOvinger(br.getMail(), emne); //henter godkj �vinger til delemnet

            if (godkj.size() != 0) {
                for (int j = 0; j < godkj.size(); j++) {
                    Oving o = godkj.get(j);
                    ovinger.set(o.getOvingnr() - 1, o);
                }
            }

            DelEmne delEmne = service2.hentDelemne(emne);   // henter delemnet

            sjekkAntOvinger(delEmne,godkj); //SJEKK ANTALL !!!

            delEmne.setStudentovinger(ovinger);
            a.add(delEmne);

            Emne emnet = service2.hentEmne(emne);    //lager emnet
            emnet.setDelemner(a);
            em.add(emnet);

            br.setEmne(em);
        }
        session.setAttribute("ovingsoversikt", alle);
    }

    private boolean sjekkAntOvinger(DelEmne delEmne, ArrayList<Oving> ovinger) {
        String[] regel = delEmne.getOvingsRegler().split("|");
        //10 7 | 3 5 8 ; 2 | 4 7 ; 1 |
        int antOvinger = Integer.parseInt(regel[0].split(" ")[0]);
        int kravGodkj = Integer.parseInt(regel[0].split(" ")[1]);
        int antallGodkj = 0;

        for (int i = 0; i < ovinger.size(); i++) {
            Oving o = ovinger.get(i);
            if(o.isGodkjent()) {
                antallGodkj++;
            }
        }
        if (antallGodkj < kravGodkj) {
            return false;
        }

        for (int j = 1; j < regel.length; j++) {
            String[] regelS = regel[j].split(";");
            String[] ovingerS = regelS[0].split(" ");
            int gjort = 0;
            int krav = Integer.parseInt(regelS[1].trim());

            for (int k = 0; k < ovingerS.length; k++) {
                int krevdOving = Integer.parseInt(ovingerS[k].trim());
                if (ovinger.get(krevdOving-1).isGodkjent()) {
                    gjort++;
                }
            }
            if (gjort < krav) {
                return false;
            }
        }
        return true;
    }
}