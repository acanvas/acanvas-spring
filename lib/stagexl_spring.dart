library stagexl_spring;

//@MirrorsUsed( metaTargets: const[Retain])
//import 'dart:mirrors' show reflect, MirrorsUsed;

import 'dart:math';
import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl/stagexl.dart';


// SPRING #####
//context 
part 'src/context/config/i_configuration_package.dart';
part 'src/context/config/loader_info.dart';

part 'src/context/event/context_event.dart';
part 'src/context/impl/default_application_context_initializer.dart';
part 'src/context/impl/spring_application_context.dart';
part 'src/context/i_application_context.dart';
part 'src/context/i_application_context_aware.dart';
part 'src/context/i_application_context_initializer.dart';

//ioc
part 'src/ioc/autowire/i_autowire_processor.dart';
part 'src/ioc/autowire/i_autowire_processor_aware.dart';
part 'src/ioc/autowire/autowire_mode.dart';
//ioc/config
part 'src/ioc/config/property/i_properties_parser.dart';
part 'src/ioc/config/property/i_properties_provider.dart';
part 'src/ioc/config/property/text_file_uri.dart';
part 'src/ioc/config/i_object_definitions_provider.dart';
part 'src/ioc/config/i_text_files_loader.dart';
part 'src/ioc/config/impl/text_files_loader.dart';
part 'src/ioc/config/impl/abstract_object_definitions_provider.dart';
part 'src/ioc/config/impl/default_object_definitions_provider.dart';
part 'src/ioc/config/property/impl/key_value_properties_parser.dart';
part 'src/ioc/config/property/impl/properties.dart';
//factory
part 'src/ioc/factory/i_instance_cache.dart';
part 'src/ioc/factory/i_object_factory.dart';
part 'src/ioc/factory/impl/default_instance_cache.dart';
part 'src/ioc/factory/impl/default_object_factory.dart';
part 'src/ioc/factory/event/object_factory_event.dart';
part 'src/ioc/factory/process/i_object_factory_post_processor.dart';
part 'src/ioc/factory/process/i_object_post_processor.dart';
part 'src/ioc/i_dependency_injector.dart';
part 'src/ioc/i_object_destroyer.dart';
part 'src/ioc/impl/default_object_destroyer.dart';
part 'src/ioc/factory/process/impl/factory/abstract_ordered_factory_post_processor.dart';
part 'src/ioc/factory/process/impl/object/application_context_aware_object_post_processor.dart';
//objectdefinition
part 'src/ioc/objectdefinition/i_object_definition.dart';
part 'src/ioc/objectdefinition/i_base_object_definition.dart';
part 'src/ioc/objectdefinition/i_object_definition_registry.dart';
part 'src/ioc/objectdefinition/i_object_definition_registry_aware.dart';
part 'src/ioc/objectdefinition/object_definition_scope.dart';
part 'src/ioc/objectdefinition/impl/default_object_definition_registry.dart';
part 'src/ioc/objectdefinition/impl/property_definition.dart';
part 'src/ioc/objectdefinition/impl/object_definition.dart';
//mvc
part 'src/mvc/impl/controller.dart';
part 'src/mvc/i_controller.dart';
part 'src/mvc/processor/mvccontroller_object_factory_post_processor.dart';
//util
part 'src/util/context_utils.dart';
part 'src/util/multiline_string.dart';
