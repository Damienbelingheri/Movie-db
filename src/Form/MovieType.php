<?php

namespace App\Form;

use App\Entity\Category;
use App\Entity\Movie;
use App\Entity\Person;
use App\Entity\Post;
use Doctrine\DBAL\Types\DateType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\DateType as TypeDateType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\File;

class MovieType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add(
            'title',
            TextType::class,
            [
                "label" => "Titre"
            ]
        );
        $builder->add(
            'releaseDate',
            TypeDateType::class,
            [
                "label" => "Date de sortie",
                "widget" => "single_text",
            ]
        );

        $builder->add('categories', EntityType::class, [
            'multiple' => true,
            'expanded' => true,
            "label" => "Catégories",
            'class' => Category::class,
            'choice_label' => 'label'
        ]);

        $builder->add('director', EntityType::class, [
            "label" => "Réalisateur",
            'class' => Person::class,
            'choice_label' => 'name'
        ]);

        $builder->add('writers', EntityType::class, [
            "label" => "Scénaristes",
            'multiple' => true,
            'class' => Person::class,
            'choice_label' => 'name'
        ]);

        $builder->add('picture', FileType::class,[
            'label' => 'Image (Jpg,Jpeg,Png)',
            'mapped' => false,
             'constraints' => [
                new File([
                    'maxSize' => '2024k',
                    'mimeTypes' => [
                        'image/*',
                    ],
                    'mimeTypesMessage' => 'Please upload a valid Image',
                ])
            ] 
        ]);
/* 
        $builder->add('post', EntityType::class, [
            'multiple' => true,
            'expanded' => true,
            'class' => Post::class,
            'choice_label' => 'title'
        ]); */


    }




    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Movie::class,
        ]);
    }
}
