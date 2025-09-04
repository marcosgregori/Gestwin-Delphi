<?php
/**
 * Copyright © Magento, Inc. All rights reserved.
 * See COPYING.txt for license details.
 */
use Magento\Framework\App\Action\Action;

?>
<?php
/**
 * Product list template
 *
 * @var $block \Magento\Catalog\Block\Product\ListProduct
 * @var \Magento\Framework\Escaper $escaper
 * @var \Magento\Framework\View\Helper\SecureHtmlRenderer $secureRenderer
 */
?>
<?php
$_productCollection = $block->getLoadedProductCollection();
/** @var \Magento\Catalog\Helper\Output $_helper */
$_helper = $block->getData('outputHelper');
?>

<!-- Variables -->

    <?php

$objectManager =  \Magento\Framework\App\ObjectManager::getInstance();        
$storeManager  = $objectManager->get('\Magento\Store\Model\StoreManagerInterface');
$storeName     = $storeManager->getStore()->getName();

$storeID = $storeManager->getStore()->getStoreId(); $storeName = $storeManager->getStore()->getName();
                
?>

<!-- Variables (FIN) -->

<?php if (!$_productCollection->count()): ?>
    <div class="message info empty">
        <div><?= $escaper->escapeHtml(__('We can\'t find products matching the selection.')) ?></div>
    </div>
<?php else: ?>
    <?= $block->getToolbarHtml() ?>
    <?= $block->getAdditionalHtml() ?>
    <?php
    if ($block->getMode() === 'grid') {
        $viewMode = 'grid';
        $imageDisplayArea = 'category_page_grid';
        $showDescription = false;
        $templateType = \Magento\Catalog\Block\Product\ReviewRendererInterface::SHORT_VIEW;
    } else {
        $viewMode = 'list';
        $imageDisplayArea = 'category_page_list';
        $showDescription = true;
        $templateType = \Magento\Catalog\Block\Product\ReviewRendererInterface::FULL_VIEW;
    }
    /**
     * Position for actions regarding image size changing in vde if needed
     */
    $pos = $block->getPositioned();
    ?>
    <div class="products wrapper <?= /* @noEscape */ $viewMode ?> products-<?= /* @noEscape */ $viewMode ?>">
        <ol class="products list items product-items">
            <?php /** @var $_product \Magento\Catalog\Model\Product */ ?>
            <?php foreach ($_productCollection as $_product): ?>
            <li class="item product product-item">
                <div class="product-item-info"
                     id="product-item-info_<?= /* @noEscape */ $_product->getId() ?>"
                     data-container="product-<?= /* @noEscape */ $viewMode ?>">
                    <?php
                    $productImage = $block->getImage($_product, $imageDisplayArea);
                    if ($pos != null) {
                        $position = 'left:' . $productImage->getWidth() . 'px;'
                            . 'top:' . $productImage->getHeight() . 'px;';
                    }
                    ?>
                    <?php // Product Image ?>
                    <a href="<?= $escaper->escapeUrl($_product->getProductUrl()) ?>"
                       class="product photo product-item-photo"
                       tabindex="-1">
                        <?= $productImage->toHtml() ?>
                    
                                        <?php /* Galería de imagenes en product list */ ?>           
            
    <div class="scrolling-wrapper">       
            
<?php
    $objectManager = \Magento\Framework\App\ObjectManager::getInstance();
    $product = $objectManager->create('Magento\Catalog\Model\Product')->load($_product->getId());        
    $images = $product->getMediaGalleryImages();
    foreach($images as $child){ ?>                        
    <img src="<?php echo $child->getUrl(); ?>" >
    
<?php } ?>
   
    
    </div id="botones_scrollhorizontal">
                    
    <?php /* Botones horizontal scroll */ ?>
    
    <div id="botones_scrollhorizontal" style="width:314px;">
    
    <button id="slideLeft" type="button"> < </button>
    <button id="slideRight" type="button"> > </button>
    
    </div>
    
<?php /* Botones horizontal scroll (FIN) */ ?> 
                    
                    
                    </a>
    
    <?php /* Galería de imagenes en product list (FIN) */ ?>
    
                    
                    <div class="product details product-item-details">
                        <?php
                            $_productNameStripped = $block->stripTags($_product->getName(), null, true);
                        ?>
                    
 <?php  // Nombre del producto en portugués ?>  
                        
                        
                        <?php  if($storeID == 1){ ?>
                        
                      	<strong class="product name product-item-name">
                            <a class="product-item-link"
                               href="<?= $block->escapeUrl($_product->getProductUrl()) ?>">
                                <?= /* @noEscape */ $_helper->productAttribute($_product, $_product->getName(), 'name') ?>
                            </a>  
                        </strong>
                        
                       <?php  }elseif($storeID == 2){ ?>
                        
                        <strong class="product name product-item-name">
                            <a class="product-item-link"
                               href="<?= $escaper->escapeUrl($_product->getProductUrl()) ?>">
                               <?php /* @escapeNotVerified */ echo $_product->getResource()->getAttribute('portugues')->getFrontend()->getValue($_product); ?>
                            </a>  
                        </strong>
                        
                      <?php } ?>
                        
                        
 <?php  // Nombre del producto en portugués ( FIN ) ?>                          
                        
                        
                        
<div id="categoria_precio"><?php /* @escapeNotVerified */ echo number_format((float)$_product->getResource()->getAttribute('price')->getFrontend()->getValue($_product), 2, ',', ''); ?> €  </div>  
    
                    <div class="product details product-item-details">
                        <?= $block->getReviewsSummaryHtml($_product, $templateType) ?>
                        <?= /* @noEscape */ $block->getProductPrice($_product) ?>



<?php // Disponibilidad ?>

<?php  if($storeID == 1){ ?>                        
                        
<div id="disponibilidad"> Disponibilidad:  <span id="disponibilidad_fecha"> <?php /* @escapeNotVerified */ echo $_product->getResource()->getAttribute('disponibilidad')->getFrontend()->getValue($_product); ?> </span> </div>                      

<?php  }elseif($storeID == 2){ ?>  

<div id="disponibilidad"> Disponibilidade:  <span id="disponibilidad_fecha"> <?php /* @escapeNotVerified */ echo $_product->getResource()->getAttribute('disponibilidad')->getFrontend()->getValue($_product); ?> </span> </div>

<?php } ?>  

<?php // Disponibilidad ( FIN ) ?>

<?php // Tabla de tallas ?>

<?php $imagentalla = $_product->getResource()->getAttribute('imagentalla')->getFrontend()->getValue($_product); ?>

<?php if($storeID == 1){ ?>

<div id='ver_talla'>

<button>Guía de Tallas</button>

<div>

<div id='imagen_talla'>

<?php 

if (!empty($imagentalla)) {
/* @escapeNotVerified */ echo '<img src="http://hilaturastemprado.com/img_adicionales/tallas/'.$imagentalla.'">'; 
}
?>

</div>

<?php }elseif($storeID == 2){ ?>

<div id='ver_talla'>

<button>Guia de tamanhos</button>

<div>

<div id='imagen_talla'>

<?php 

if (!empty($imagentalla)) {
/* @escapeNotVerified */ echo '<img src="http://hilaturastemprado.com/img_adicionales/tallas/'.$imagentalla.'">'; 
}
?>

</div>

<?php } ?>

<?php // Tabla de tallas ( FIN ) ?>                        
                        
                        
                        <div class="product-item-inner">
                            <div class="product actions product-item-actions">
                                <div class="actions-primary">
                                    <?php if ($_product->isSaleable()):?>
                                        <?php $postParams = $block->getAddToCartPostParams($_product); ?>
                                        <form data-role="tocart-form"
                                              data-product-sku="<?= $escaper->escapeHtml($_product->getSku()) ?>"
                                              action="<?= $escaper->escapeUrl($postParams['action']) ?>"
                                              data-mage-init='{"catalogAddToCart": {}}'
                                              method="post">
                                            <?php $options = $block->getData('viewModel')->getOptionsData($_product); ?>
                                            <?php foreach ($options as $optionItem): ?>
                                                <input type="hidden"
                                                       name="<?= $escaper->escapeHtml($optionItem['name']) ?>"
                                                       value="<?= $escaper->escapeHtml($optionItem['value']) ?>">
                                            <?php endforeach; ?>
                                            <input type="hidden"
                                                   name="product"
                                                   value="<?= /* @noEscape */ $postParams['data']['product'] ?>">
                                            <input type="hidden"
                                                   name="<?= /* @noEscape */ Action::PARAM_NAME_URL_ENCODED ?>"
                                                   value="<?=
                                                   /* @noEscape */ $postParams['data'][Action::PARAM_NAME_URL_ENCODED]
                                                    ?>">
                                            <?= $block->getBlockHtml('formkey') ?>
                                            
                                            <?php // Desplazado al interior del form. Añadido el id del addtocart button ?>

                                                <?= $block->getProductDetailsHtml($_product) ?>

                                                <?php
                                                    /* En el button he quitado la clase 'tocart' que se utiliza para activar el botón más adelante.
                                                       Activo o desactivo el botón inicialmente dependiendo del tipo de artículo. Si es configurable,
                                                       es decir, que tiene variantes, está inicialmente desactivado y la gestión de la activación
                                                       se deja a swatch-renderer-mixin.js
                                                    */
                                                ?>
                                            
                                            <button type="submit"
                                                    title="<?= $escaper->escapeHtmlAttr(__('Add to Cart')) ?>"
                                                    class="action tocart primary"
                                                    disabled>
                                                <span><?= $escaper->escapeHtml(__('Add to Cart')) ?></span>
                                            </button>
                                        </form>
                                    <?php else:?>
                                        <?php if ($_product->isAvailable()):?>
                                            <div class="stock available">
                                                <span><?= $escaper->escapeHtml(__('In stock')) ?></span></div>
                                        <?php else:?>
                                            <div class="stock unavailable">
                                                <span><?= $escaper->escapeHtml(__('Out of stock')) ?></span></div>
                                        <?php endif; ?>
                                    <?php endif; ?>
                                </div>
                                <?= ($pos && strpos($pos, $viewMode . '-primary')) ?
                                    /* @noEscape */ $secureRenderer->renderStyleAsTag(
                                        $position,
                                        'product-item-info_' . $_product->getId() . ' div.actions-primary'
                                    ) : '' ?>
                                <div data-role="add-to-links" class="actions-secondary">
                                    <?php if ($addToBlock = $block->getChildBlock('addto')): ?>
                                        <?= $addToBlock->setProduct($_product)->getChildHtml() ?>
                                    <?php endif; ?>
                                </div>
                                <?= ($pos && strpos($pos, $viewMode . '-secondary')) ?
                                    /* @noEscape */ $secureRenderer->renderStyleAsTag(
                                        $position,
                                        'product-item-info_' . $_product->getId() . ' div.actions-secondary'
                                    ) : '' ?>
                            </div>
                            <?php if ($showDescription): ?>

                            
                             <?php  // Descripción del producto en portugués ?>  
                        
                        
                        <?php  if($storeID == 1){ ?>
                        
                                <div class="product description product-item-description">
                                    <?= /* @noEscape */ $_helper->productAttribute(
                                        $_product,
                                        $_product->getShortDescription(),
                                        'short_description'
                                    ) ?>
                        
                       <?php  }elseif($storeID == 2){ ?>
                        
								<div id="descripcion_portugues"><?php /* @escapeNotVerified */ echo $_product->getResource()->getAttribute('descr_portugues')->getFrontend()->getValue($_product); ?></div>
                        
                      <?php } ?>
                        
                        
 						<?php  // Descripción del producto en portugués ( FIN ) ?>  
                            
                            
                                    <a href="<?= $escaper->escapeUrl($_product->getProductUrl()) ?>"
                                       title="<?= /* @noEscape */ $_productNameStripped ?>"
                                       class="action more"><?= $escaper->escapeHtml(__('Learn More')) ?></a>
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
                <?= ($pos && strpos($pos, $viewMode . '-actions')) ?
                /* @noEscape */ $secureRenderer->renderStyleAsTag(
                    $position,
                    'product-item-info_' . $_product->getId() . ' div.product-item-actions'
                ) : '' ?>
            </li>
            <?php endforeach; ?>
        </ol>
    </div>
    <?= $block->getChildBlock('toolbar')->setIsBottom(true)->toHtml() ?>
    <?php // phpcs:ignore Magento2.Legacy.PhtmlTemplate ?>
<?php endif; ?>
