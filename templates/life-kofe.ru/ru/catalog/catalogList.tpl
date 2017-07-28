<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <link rel="stylesheet" href="/css/<?=$this->getCurrentDomainAlias()?>/pages/products_category.css">

    <?if(isset($category) && $category):?>
    <header id="page-header">
        <h1 class="container"><?=$category->getName()?></h1>
    </header>
    <?endif?>

    <?$this->getController('Catalog')->getFilter()?>

    <?$this->setContent('breadcrumbsShow', true)->includeTemplate('breadCrumbs')?>

    <?if(isset($isSearch) && $isSearch):?>
    <h1>Результаты поиска</h1>
    <?endif?>

    <?if(isset($subCategories) && $subCategories && $subCategories->count()):?>
    <section class="container">
        <ul class="list-of-products list-unstyled">
            <?foreach($subCategories as $subCategory):?>
            <li class="col-lg-3 col-md-4 col-sm-6">
                <figure class="thumbnail product">
                    <picture
                        class="product--image"
                        style="background-image: url(<?//=$subCategory->current()->getFirstPrimaryImage()->getImage('236x150')?>);"
                    ></picture>
                    <figcaption class="caption">
                        <h5 class="product--name"><?=$subCategory->getName()?></h5>
                        <div class="text-center">
                            <a href="<?=$subCategory->getPath()?>" class="btn btn-link">Подробнее</a>
                        </div>
                    </figcaption>
                </figure>
            </li>
           <?endforeach?>
        </ul>
    </section>

    <div class="clear"></div>
    <br><br><br><br><br><br>

    <?endif?>

    <?if($objects->count()):?>
    <section class="container">
        <ul class="row list-unstyled list-of-products">
            <?foreach($objects as $object):?>

            <?if($this->getController('Authorization')->isAdminAuthorizated()):?>
            <a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
                Редактировать [id = <?=$object->id?>]
            </a>
            <?endif?>

            <li class="col-lg-3 col-md-4 col-sm-6">
                <figure class="thumbnail product">
                    <a href="<?=$object->getPath()?>">
                        <picture class="product--image" style="background-image: url(<?=$object->getFirstPrimaryImage()->getImage('236x150')?>);"></picture>
                    </a>
                    <figcaption class="caption">
                        <a href="<?=$object->getPath()?>">
                            <h5 class="product--name"><?=$object->getInfo()->getName()?></h5>
                        </a>
                        <form action="" method="POST" role="form">
                            <div class="row">
                                <div class="col-xs-8">
                                  <span class="product--price">
                                      <var class="product--price"><?=number_format( $object->getShowPrice(), 2, '.', ' ' )?></var>
                                      <label>р.</label>
                                  </span>
                                </div>
                                <div class="col-xs-4">
                                    <select
                                        name=""
                                        class="form-control input-sm byeMoreQuantity"
                                        required="required"
                                        data-objectId="<?=$object->id?>"
                                    >
                                        <?for($i=1; $i<$itemsInSelect+1; $i++):?>
                                        <option value="<?=$i?>"><?=$i?></option>
                                        <?endfor?>
                                    </select>
                                </div>
                            </div>
                            <div class="product-actions text-center">
                                <button
                                    class="btn btn-info addToShopcart"
                                    data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"
                                >В корзину</button>
                            </div>
                        </form>
                    </figcaption>
                </figure>
            </li>
            <?endforeach?>
        </ul>

        <?include('paginator.tpl')?>

    </section>
    <?endif?>

    <?if(isset($isSearch) && $isSearch && !$objects->count()):?>
    <section id="search-no-results" class="-hidden container has-padding">
        <figure class="text-center text-warning">
            <img src="/images/bg/pages/searching_results/a-cap-of-coffe.svg" alt="Чашечка кофе с грустным смайликом">
            <figcaption>
                <h4><strong>К сожалению поиск не дал результата.</strong></h4>
                <p>Начните поиск с другими параметрами или <a href="#">свяжитесь с нашими менеджерами</a>
                    <br> для консультации
                </p>
            </figcaption>
        </figure>
    </section>
    <?endif?>

<?$this->includeTemplate('footer')?>