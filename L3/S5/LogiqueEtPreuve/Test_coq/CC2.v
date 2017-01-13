(* 

 Ce fichier est disponible à la page suivante

  https://www.labri.fr/~casteran/L-et-P/Test/
  utilisateur : testCoq
  mot de passe : 5Octobre



Mode d'emploi 

  Remplacer les tactiques automatiques "tauto" par une vraie preuve Coq.
  Envoyer a votre charge de TD *)



Section test2.
  Variables P Q R : Prop.

  Section proof1.
    Hypothesis H : P -> Q.
    Lemma L1 : ~Q -> ~P.
      Proof.
      unfold not.
      intro H0.
      intro H1.
      apply H0.
      apply H.
      assumption.
    Qed.

  End proof1.

  Section proof2.
    Hypothesis H : ~Q -> ~P.
    Lemma L2 : P -> ~~Q.
      Proof.
      unfold not.
      intro h1.
      intro  h2.
      apply H.
      assumption.
      assumption.    
    Qed.

  End proof2.

  Section proof3.
    Hypothesis HQ : ~~ Q -> Q.

    Hypothesis H : ~ Q -> ~P.

    Lemma L3 : P -> Q.
    Proof.
      unfold not.
      intro h2.
      apply HQ.
      intro HQ2.
      apply H.
      assumption.
      assumption.      
    Qed.

  End proof3.

  Section proof4.
    Hypothesis texP : P \/ ~P.
    Hypothesis H : ~(P -> Q).

    Lemma L4 : P /\ ~ Q.
    Proof.
      unfold not in H.
      unfold not in texP.
      unfold not.
      split.
      destruct texP.
      assumption.
      assert (F: False). 
      apply H.
      intro p.
      assert(F:False).
     apply H0; assumption.
     destruct F.
     destruct F.
     intro q.
     destruct texP.
     apply H.
     intro p.
     assumption.
     apply H.
     intro p.
     assert(F:False).
     apply H0; assumption.
     assumption.
    Qed.

  End proof4.


  
End test2.