<?php

namespace App\Controller;

use App\Entity\Person;
use App\Form\PersonType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/person")
 */
class PersonController extends AbstractController
{
    /**
     * @Route("/{id}/view", name="person_view", requirements={"id" = "\d+"}, methods={"GET"})
     */
    public function viewCategory($id)
    {
        $person = $this->getDoctrine()->getRepository(Person::class)->findWithFullData($id);
        return $this->render('person/view.html.twig', [
            'person' => $person,
        ]);
    }



    /**
     * @Route("/list", name="person_list", methods={"GET"})
     */
    public function listCategories()
    {
        $persons = $this->getDoctrine()->getRepository(Person::class)->findAll();
        return $this->render('person/list.html.twig', [
            'persons' => $persons,
        ]);
    }

    /**
     * @Route("/add", name="person_add", methods={"GET", "POST"})
     */
    public function addPerson(Request $request)
    {
        $newPerson = new Person();
        $form = $this->createForm(PersonType::class, $newPerson);

        $form->handleRequest($request);
        // A ce moment le formualire sait si des données ont été postées
        if ($form->isSubmitted() && $form->isValid()) {

            $manager = $this->getDoctrine()->getManager();
            $manager->persist($newPerson);
            $manager->flush();

            return $this->redirectToRoute('person_view', ['id' => $newPerson->getId()]);
        }
        // on envoi le formulaire a la template
        return $this->render(
            'person/add.html.twig',
            [
                "personForm" => $form->createView()
            ]
        );
    }
 /**
     * @Route("/{id}/update", name="person_update", requirements={"id" = "\d+"}, methods={"GET", "POST"})
     */
    public function updatePerson(Request $request, Person $person)
    {
        $form = $this->createForm(PersonType::class, $person);

        $form->handleRequest($request);
        if($form->isSubmitted() && $form->isValid()) {
            $manager = $this->getDoctrine()->getManager();
            $manager->flush();

            return $this->redirectToRoute('person_view', ['id' => $person->getId()]);
        }

        return $this->render('person/update.html.twig', [
            "personForm" => $form->createView(),
            "person" => $person
        ]);
    }

    /**
     * @Route("/{id}/delete", name="person_delete", methods={"GET", "POST"},requirements={"id" = "\d+"})
     */
    public function deletePerson(Request $request, Person $person)
    {



        $manager = $this->getDoctrine()->getManager();
        $manager->remove($person);
        $manager->flush(); 
        
        return $this->redirectToRoute('category_list');


    }
}
