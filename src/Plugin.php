<?php

/**
 * @file
 * Contains DeloitteDigital\QdTest|Plugin.
 */

namespace DeloitteDigital\QdTest;

use Composer\Composer;
use Composer\EventDispatcher\EventSubscriberInterface;
use Composer\Factory;
use Composer\IO\IOInterface;
use Composer\Plugin\PluginInterface;
use Composer\Script\Event;
use Composer\Script\ScriptEvents;

class Plugin implements PluginInterface, EventSubscriberInterface {

  /**
   * @var \Composer\Composer
   */
  protected $composer;

  /**
   * @var \Composer\IO\IOInterface
   */
  protected $io;

  /**
   * {@inheritdoc}
   */
  public function activate(Composer $composer, IOInterface $io) {
    $this->composer = $composer;
    $this->io = $io;
  }

  /**
   * {@inheritdoc}
   */
  public static function getSubscribedEvents() {
    return array(
      ScriptEvents::POST_INSTALL_CMD => 'addProboYml',
      ScriptEvents::POST_UPDATE_CMD => 'addProboYml',
    );
  }

  /**
   * Add/update project .probo.yml.
   *
   * @param \Composer\Script\Event $event
   */
  public function addProboYml(Event $event) {

    $baseDir = dirname(Factory::getComposerFile());
    $source = __DIR__ . '/../.probo.yml';
    $target =  $baseDir . '/.probo.yml';

    if (file_exists($source)) {
      if (!file_exists($target) || md5_file($source) != md5_file($target)) {
        copy($source, $target);
      }
    }
  }

}
