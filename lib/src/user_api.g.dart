// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

GraphQLObjectField<User, Object?, Object?> get getUserGraphQLField =>
    _getUserGraphQLField.value;
final _getUserGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<User, Object?, Object?>>(
        (setValue) => setValue(userGraphQLType.nonNull().field<Object?>(
              'getUser',
              resolve: (obj, ctx) {
                final args = ctx.args;

                return getUser(ctx);
              },
              description:
                  'Returns the currently authenticated user.\nThrows "unauthenticated" if the user is not authenticated.\nYou may pass the user token as header, url query parameter or as a value\nin the initial connection payload for web sockets.\nThe key of the value should be "room-signals-auth".',
            )));

GraphQLObjectField<UserCreated, Object?, Object?> get createUserGraphQLField =>
    _createUserGraphQLField.value;
final _createUserGraphQLField =
    HotReloadableDefinition<GraphQLObjectField<UserCreated, Object?, Object?>>(
        (setValue) => setValue(userCreatedGraphQLType.nonNull().field<Object?>(
              'createUser',
              resolve: (obj, ctx) {
                final args = ctx.args;
                final validationErrorMap = <String, List<ValidaError>>{};

                final _validation =
                    CreateUserArgs(ctx, (args["name"] as String?)).validate();
                validationErrorMap.addAll(_validation.errorsMap.map(
                    (k, v) => MapEntry(k is Enum ? k.name : k.toString(), v))
                  ..removeWhere((k, v) => v.isEmpty));
                if (validationErrorMap.isNotEmpty) {
                  throw GraphQLError(
                    'Input validation error',
                    extensions: {
                      'validaErrors': validationErrorMap,
                    },
                    sourceError: validationErrorMap,
                  );
                }

                return createUser(ctx, (args["name"] as String?));
              },
              description:
                  'Returns the currently authenticated user or creates a new one.',
            ))
              ..inputs.addAll([
                graphQLString.inputField('name', attachments: [
                  ValidaAttachment(ValidaString(minLength: 2)),
                ])
              ]));

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final _userGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<User>>((setValue) {
  final __name = 'User';

  final __userGraphQLType =
      objectType<User>(__name, isInterface: false, interfaces: []);

  setValue(__userGraphQLType);
  __userGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('userId',
          resolve: (obj, ctx) => obj.userId, description: 'A unique user id'),
      graphQLString.field('name',
          resolve: (obj, ctx) => obj.name,
          description: 'An optional name for the user')
    ],
  );

  return __userGraphQLType;
});

/// Auto-generated from [User].
GraphQLObjectType<User> get userGraphQLType => _userGraphQLType.value;

final _userCreatedGraphQLType =
    HotReloadableDefinition<GraphQLObjectType<UserCreated>>((setValue) {
  final __name = 'UserCreated';

  final __userCreatedGraphQLType =
      objectType<UserCreated>(__name, isInterface: false, interfaces: []);

  setValue(__userCreatedGraphQLType);
  __userCreatedGraphQLType.fields.addAll(
    [
      graphQLString.nonNull().field('token',
          resolve: (obj, ctx) => obj.token,
          description:
              'The user token. You may save this, but do not share it.\nView getUser query documentation for more info.'),
      userGraphQLType.nonNull().field('user', resolve: (obj, ctx) => obj.user)
    ],
  );

  return __userCreatedGraphQLType;
});

/// Auto-generated from [UserCreated].
GraphQLObjectType<UserCreated> get userCreatedGraphQLType =>
    _userCreatedGraphQLType.value;

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

/// The arguments for [createUser].
class CreateUserArgs with ValidaToJson {
  final Ctx<dynamic> ctx;
  final String? name;

  /// The arguments for [createUser].
  const CreateUserArgs(
    this.ctx,
    this.name,
  );

  /// Validates this arguments for [createUser].
  CreateUserArgsValidation validate() =>
      CreateUserArgsValidation.fromValue(this);

  /// Validates this arguments for [createUser] and
  /// returns the successfully [Validated] value or
  /// throws a [CreateUserArgsValidation] when there is an error.
  Validated<CreateUserArgs> validatedOrThrow() {
    final validation = validate();
    final validated = validation.validated;
    if (validated == null) {
      throw validation;
    }
    return validated;
  }

  @override
  Map<String, Object?> toJson() => {
        'ctx': ctx,
        'name': name,
      };

  @override
  String toString() => 'CreateUserArgs${toJson()}';

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateUserArgs &&
            ctx == other.ctx &&
            name == other.name);
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        ctx,
        name,
      );
}

enum CreateUserArgsField {
  name,
}

class CreateUserArgsValidationFields {
  const CreateUserArgsValidationFields(this.errorsMap);
  final Map<CreateUserArgsField, List<ValidaError>> errorsMap;

  List<ValidaError> get name => errorsMap[CreateUserArgsField.name] ?? const [];
}

class CreateUserArgsValidation
    extends Validation<CreateUserArgs, CreateUserArgsField> {
  CreateUserArgsValidation(this.errorsMap, this.value)
      : fields = CreateUserArgsValidationFields(errorsMap),
        super(errorsMap);
  @override
  final Map<CreateUserArgsField, List<ValidaError>> errorsMap;
  @override
  final CreateUserArgs value;
  @override
  final CreateUserArgsValidationFields fields;

  /// Validates [value] and returns a [CreateUserArgsValidation] with the errors found as a result
  factory CreateUserArgsValidation.fromValue(CreateUserArgs value) =>
      spec.validate(value);

  static const spec = ValidaSpec(
    globalValidate: null,
    validationFactory: CreateUserArgsValidation.new,
    getField: _getField,
    fieldsMap: {
      CreateUserArgsField.name: ValidaString(minLength: 2),
    },
  );

  static List<ValidaError> _globalValidate(CreateUserArgs value) => [];

  static Object? _getField(CreateUserArgs value, String field) {
    switch (field) {
      case 'ctx':
        return value.ctx;
      case 'name':
        return value.name;
      default:
        throw Exception('Could not find field "$field" for value $value.');
    }
  }
}
