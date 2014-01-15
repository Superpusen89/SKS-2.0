package no.hist.tdat.javabeans.beanservice;

import no.hist.tdat.database.DatabaseConnector;
import no.hist.tdat.javabeans.Bruker;
import no.hist.tdat.javabeans.Emne;
import no.hist.tdat.javabeans.Emne;
import no.hist.tdat.javabeans.Oving;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class EmneService {

    @Qualifier("databaseConnector")
    @Autowired
    DatabaseConnector databaseConnector;




    public void hentEmner(Bruker bruker) {
       bruker.setEmne((ArrayList<Emne>) databaseConnector.hentMineEmner(bruker));
       ArrayList<Emne> tempList = bruker.getEmne();
       bruker.setEmne(databaseConnector.hentMineEmner(bruker));
       /*ArrayList<Emne> tempList = bruker.getEmne();                           //TODO Ted

        for (int i = 0; i < tempList.size(); i++) {
            ArrayList<Oving> ovinger = databaseConnector.hentStudOvinger(bruker, tempList.get(i));
            tempList.get(i).setStudentovinger(ovinger);
        }*/
    }
    public boolean endreKoeStatus(int koeId, int status){
        return databaseConnector.endreKoeStatus(koeId, status);
    }

}