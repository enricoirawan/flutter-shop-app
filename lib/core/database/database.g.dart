// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao? _cartDaoInstance;

  TransactionDao? _transactionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cart` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `productTitle` TEXT NOT NULL, `price` REAL NOT NULL, `amount` INTEGER NOT NULL, `image` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TransactionData` (`id` TEXT NOT NULL, `total` REAL NOT NULL, `purcashedProductTitle` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }

  @override
  TransactionDao get transactionDao {
    return _transactionDaoInstance ??=
        _$TransactionDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cartInsertionAdapter = InsertionAdapter(
            database,
            'Cart',
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'productTitle': item.productTitle,
                  'price': item.price,
                  'amount': item.amount,
                  'image': item.image
                }),
        _cartUpdateAdapter = UpdateAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'productTitle': item.productTitle,
                  'price': item.price,
                  'amount': item.amount,
                  'image': item.image
                }),
        _cartDeletionAdapter = DeletionAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'productTitle': item.productTitle,
                  'price': item.price,
                  'amount': item.amount,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cart> _cartInsertionAdapter;

  final UpdateAdapter<Cart> _cartUpdateAdapter;

  final DeletionAdapter<Cart> _cartDeletionAdapter;

  @override
  Future<List<Cart>> getAllCarts() async {
    return _queryAdapter.queryList('SELECT * FROM Cart',
        mapper: (Map<String, Object?> row) => Cart(
            id: row['id'] as int,
            productTitle: row['productTitle'] as String,
            price: row['price'] as double,
            amount: row['amount'] as int,
            image: row['image'] as String));
  }

  @override
  Future<bool?> clearCarts() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Cart');
  }

  @override
  Future<int> insertCart(Cart cart) {
    return _cartInsertionAdapter.insertAndReturnId(
        cart, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCart(Cart cart) {
    return _cartUpdateAdapter.updateAndReturnChangedRows(
        cart, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCart(Cart cart) {
    return _cartDeletionAdapter.deleteAndReturnChangedRows(cart);
  }
}

class _$TransactionDao extends TransactionDao {
  _$TransactionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _transactionDataInsertionAdapter = InsertionAdapter(
            database,
            'TransactionData',
            (TransactionData item) => <String, Object?>{
                  'id': item.id,
                  'total': item.total,
                  'purcashedProductTitle': item.purcashedProductTitle
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TransactionData> _transactionDataInsertionAdapter;

  @override
  Future<List<TransactionData>> getAllTransactions() async {
    return _queryAdapter.queryList('SELECT * FROM TransactionData',
        mapper: (Map<String, Object?> row) => TransactionData(
            id: row['id'] as String,
            total: row['total'] as double,
            purcashedProductTitle: row['purcashedProductTitle'] as String));
  }

  @override
  Future<int> insertTransaction(TransactionData transaction) {
    return _transactionDataInsertionAdapter.insertAndReturnId(
        transaction, OnConflictStrategy.abort);
  }
}
