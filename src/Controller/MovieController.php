<?php

namespace App\Controller;

use App\Form\MovieType;
use App\Entity\Movie;
use App\Entity\Person;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

/**
 * @Route("/movie")
 */
class MovieController extends AbstractController
{

    /**
     * @Route("/list", name="movie_list", methods={"GET"})
     */
    public function list(Request $request)
    {

        $search = $request->query->get("search", "");

        /* 
        $movies = $this->getDoctrine()->getRepository(Movie::class)->findBy(
            ["title" => $search], // WHERE title = "search"
            ["title" => "asc"]
        );

        // on a plutot besoin d'un title LIKE "%search%"
        */

        $movies = $this->getDoctrine()->getRepository(Movie::class)->findByPartialTitle($search);

        return $this->render('movie/list.html.twig', [
            "movies" => $movies,
            "search" => $search
        ]);
    }

    /**
     * @Route("/{id}/view", name="movie_view", requirements={"id" = "\d+"}, methods={"GET"})
     */
    public function view($id)
    {
        $movie = $this->getDoctrine()->getRepository(Movie::class)->findWithFullData($id);

        if (!$movie) {
            throw $this->createNotFoundException("Ce film n'existe pas !");
        }

        return $this->render('movie/view.html.twig', [
            'movie' => $movie,
        ]);
    }

    /**
     * @Route("/add", name="movie_add", methods={"GET", "POST"})
     */
    public function addMovie(Request $request, SluggerInterface $slugger )
    {
        // creer une entité qui sera gérée par le formulaire
        $newMovie = new Movie();

        $form = $this->createForm(MovieType::class, $newMovie);

        $form->handleRequest($request);
        // A ce moment le formualire sait si des données ont été postées
        if ($form->isSubmitted() && $form->isValid()) {
            // si des données ont été soumises , on traite le formulaire
            //$data = $form->getData();
            // pas besoin de ce getData car l'objet  géré par le formulaire c'est $newMovie
            $manager = $this->getDoctrine()->getManager();
           
            $picture = $form->get('picture')->getData();

            if ($picture) {
                $originalFilename = pathinfo($picture->getClientOriginalName(), PATHINFO_FILENAME);
                // this is needed to safely include the file name as part of the URL
                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename.'-'.uniqid().'.'.$picture->guessExtension();

                // Move the file to the directory where brochures are stored
                try {
                    $picture->move(
                        $this->getParameter('images_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                  dump('coucou');
                }

                // updates the 'picturename' property to store the PDF file name
                // instead of its contents
                $newMovie->setPicture($newFilename);
            }

            $manager->persist($newMovie);
            $manager->flush();

            return $this->redirectToRoute('movie_list');
        }

        // on envoi le formulaire a la template
        return $this->render(
            'movie/add.html.twig',
            [
                "movieForm" => $form->createView()
            ]
        );
    }


    /**
     * @Route("/{id}/update", name="movie_update", methods={"GET", "POST"})
     */
    public function updateMovie(Request $request,Movie $movie, SluggerInterface $slugger )
    {
        // creer une entité qui sera gérée par le formulaire
       

        $form = $this->createForm(MovieType::class, $movie);

        $form->handleRequest($request);
        // A ce moment le formualire sait si des données ont été postées
        if ($form->isSubmitted() && $form->isValid()) {
            // si des données ont été soumises , on traite le formulaire
            //$data = $form->getData();
            // pas besoin de ce getData car l'objet  géré par le formulaire c'est $movie
            $manager = $this->getDoctrine()->getManager();
           
            $picture = $form->get('picture')->getData();

            if ($picture) {
                $originalFilename = pathinfo($picture->getClientOriginalName(), PATHINFO_FILENAME);
                // this is needed to safely include the file name as part of the URL
                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename.'-'.uniqid().'.'.$picture->guessExtension();

                // Move the file to the directory where brochures are stored
                try {
                    $picture->move(
                        $this->getParameter('images_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                  dump('coucou');
                }

                // updates the 'picturename' property to store the PDF file name
                // instead of its contents
                $movie->setPicture($newFilename);
            }
            $manager->flush();

            return $this->redirectToRoute('movie_list');
        }

        // on envoi le formulaire a la template
        return $this->render(
            'movie/update.html.twig',
            [
                "movieForm" => $form->createView(),
                "movie" => $movie,
            ]
        );
    }


    /**
     * @Route("/{id}/delete", name="movie_delete", methods={"GET"})
     */
    public function deleteMovie(Movie $movie)
    {

        // si le film n'éxiste pas on renvoi sur une 404
        if (!$movie) {
            throw $this->createNotFoundException("Ce film n'existe pas !");
        }

        // je demande le manager
        $manager = $this->getDoctrine()->getManager();
        // je dit au manager que cette entité devra faire l'objet d'une suppression
        $manager->remove($movie);
        // je demande au manager d'executer dans la BDD toute les modifications qui ont été faites sur les entités
        $manager->flush();
        // On retourne sur la liste des films
        return $this->redirectToRoute('movie_list');
    }



}
